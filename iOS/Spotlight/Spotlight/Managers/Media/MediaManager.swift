//
//  MediaManager.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import AVFoundation
import CoreImage
import Combine


class Media:NSObject{
    
    var captureSession: AVCaptureSession? = nil
    
//    var isRearCameraPosition:Bool = true

    var frontCamera:AVCaptureDevice? = nil
    var rearCamera: AVCaptureDevice? = nil //default
    
    var microphone: AVCaptureDevice? = nil
    
    @Published var videoOutput: AVCaptureFileOutput? = nil
    @Published var previewLayer: AVCaptureVideoPreviewLayer? = nil

    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    
    
    func flipCamera(rearCameraPosition:Bool = true){
        //drop session
        guard captureSession != nil else { return }
        
        if(captureSession!.isRunning){
//            sessionQueue.async {
                
                for ip in self.captureSession!.inputs{
                    self.captureSession!.removeInput(ip)
                }
                
                for op in self.captureSession!.outputs{
                    self.captureSession!.removeOutput(op)
                }
//            }
            self.captureSession!.stopRunning()
        }
        
        //start again
//        sessionQueue.async {
//            self.captureSession!.startRunning()
//        }
        let isThere = initVideoRecorder(preset: .high, cameraPositionRear: rearCameraPosition)
        print(">> \(isThere.description)")
    }
    
    func checkPermission(for mediaType:AVMediaType) ->Bool {
        switch AVCaptureDevice.authorizationStatus(for: mediaType) {
        case .authorized: // The user has previously granted access to the camera.
            return true
            
        case .notDetermined: // The user has not yet been asked for camera access.
            return requestPermission(for: mediaType)
            
            // Combine the two other cases into the default case
        default:
            return false
        }
    }
    

    func initVideoRecorder(preset: AVCaptureSession.Preset = .high,cameraPositionRear:Bool = true)->Bool {
        
        captureSession = AVCaptureSession()
        guard let captureSession = captureSession else {return false}

        captureSession.sessionPreset = preset
        
        //Device Discovery
        if(findMicrophone() && findCamera(cameraPositionRear: cameraPositionRear) == false){
            Logger.logError("Discovery Failed")
            return false
        }
        
        let canAddMicrophone = addDeviceInput(device: microphone, sesssion: captureSession)
        
        if(canAddMicrophone == false){
            Logger.logError("Can't Add Microphone Input")
            return false
        }
        
        let canAddCamera = addDeviceInput(device: cameraPositionRear ? rearCamera : frontCamera, sesssion: captureSession)
        
        if(canAddCamera  == false){
            Logger.logError("Can't Add Camera Input")
            return false
        }

        videoOutput = AVCaptureMovieFileOutput()
        
        if captureSession.canAddOutput(videoOutput!) {
            
            captureSession.addOutput(videoOutput!)
            sessionQueue.async {
                captureSession.startRunning()
            }
            videoOutput?.connection(with: .video)?.videoOrientation = .landscapeRight
            
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.videoGravity = .resizeAspect
            previewLayer?.connection?.videoOrientation = .portrait
            return true
        }
        Logger.logError("Failed to Output!")
        return false
    }


    func startRecording()->Bool {
        guard let captureSession = captureSession, captureSession.isRunning else {return false}
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileUrl = paths[0].appendingPathComponent(getVideoName())
        try? FileManager.default.removeItem(at: fileUrl)
        videoOutput?.startRecording(to: fileUrl, recordingDelegate: self)
        return true
    }
    
    
    func getVideoName()->String{
        return "----"
    }
}

extension Media{
    private func requestPermission(for mediaType:AVMediaType)->Bool {
        var isGranted:Bool = false
        AVCaptureDevice.requestAccess(for: mediaType) { granted in
            isGranted = granted
        }
        return isGranted
    }
    
    private func findMicrophone()->Bool{
        microphone = nil
        
        let session = AVCaptureDevice.DiscoverySession.init(deviceTypes:[.builtInMicrophone],
                                                            mediaType: .audio,position: AVCaptureDevice.Position.unspecified)
        let devices = (session.devices.compactMap{$0})
        
        for device in devices {
            if device.hasMediaType(.audio) {
                microphone = device
                return true
            }
        }
        Logger.logError("No Microphone Found")
        return false
    }
    
    private func addDeviceInput(device:AVCaptureDevice?,sesssion:AVCaptureSession)->Bool{
        
        guard device != nil else { return false}
        
        do {
            let deviceInput = try AVCaptureDeviceInput(device: device!)
            
            guard sesssion.canAddInput(deviceInput) else { return false}
            
            sesssion.addInput(deviceInput)
            return true
        } catch {
            return false
        }
    }
    
    
    private func findCamera(cameraPositionRear:Bool = true)->Bool{
        
        frontCamera = nil
        rearCamera = nil
        
        let session = AVCaptureDevice.DiscoverySession.init(deviceTypes:[.builtInWideAngleCamera],
                                                            mediaType: AVMediaType.video, position: cameraPositionRear ? AVCaptureDevice.Position.back : AVCaptureDevice.Position.front)
        let devices = (session.devices.compactMap{$0})
        
        for device in devices {
            if((cameraPositionRear == true) && (device.position == .back)){
                
                do {
                    try device.lockForConfiguration()
                    device.focusMode = .continuousAutoFocus
                    device.whiteBalanceMode = .continuousAutoWhiteBalance
                    device.unlockForConfiguration()
                    rearCamera = device
                    
                    return true
                } catch {
                    Logger.logError("No Rear Camera fround")
                    return false
                }
                
            }
            
            else if((cameraPositionRear == false) && (device.position == .front)){
                
                do {
                    try device.lockForConfiguration()
                    device.whiteBalanceMode = .continuousAutoWhiteBalance
                    device.unlockForConfiguration()
                    frontCamera = device
                    
                    return true
                } catch {
                    Logger.logError("No Front Camera fround")
                    return false
                }

            }
        }
        Logger.logError("No Camera Fount :(")
        return false
    }
}

extension Media:AVCaptureFileOutputRecordingDelegate{
    
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {
        
    }
}



/*
 private func findDevices() {
     frontCamera = nil
     rearCamera = nil
     
     microphone = nil

     //Search for video media type and we need back camera only
     let session = AVCaptureDevice.DiscoverySession.init(deviceTypes:[.builtInWideAngleCamera],
                                                         mediaType: AVMediaType.video, position: isRearCameraPosition ? AVCaptureDevice.Position.back : AVCaptureDevice.Position.front)
     var devices = (session.devices.compactMap{$0})
     
     //Search for microphone
     let asession = AVCaptureDevice.DiscoverySession.init(deviceTypes:[.builtInMicrophone],
             mediaType: AVMediaType.audio, position: AVCaptureDevice.Position.unspecified)
     
     //Combine all devices into one list
     devices.append(contentsOf: asession.devices.compactMap{$0})
     for device in devices {
         if (device.position == .back){
             do {
                 try device.lockForConfiguration()
                 device.focusMode = .continuousAutoFocus
                 device.whiteBalanceMode = .continuousAutoWhiteBalance
                 device.unlockForConfiguration()
                 rearCamera = device
             } catch {
                 
             }
         }
         else if(device.position == .front){
             
             do {
                 try device.lockForConfiguration()

                 device.whiteBalanceMode = .continuousAutoWhiteBalance
                 device.unlockForConfiguration()
                 frontCamera = device
             } catch {
                 
             }
         }
         if device.hasMediaType(.audio) {
             microphone = device
         }
     }
 }
 */



/*
 if let frontCamera = frontCamera{
     do {
         let cameraInput = try AVCaptureDeviceInput(device: frontCamera)
         
         guard captureSession.canAddInput(cameraInput) else { return false}
         
         captureSession.addInput(cameraInput)
     } catch {
         self.frontCamera = nil
         return false
     }
 }

 if let rearCamera = rearCamera{
     do {
         let cameraInput = try AVCaptureDeviceInput(device: rearCamera)
         
         guard captureSession.canAddInput(cameraInput) else { return false}
         
         captureSession.addInput(cameraInput)
     } catch {
         self.rearCamera = nil
         return false
     }
 }

 if let audio = microphone {
     do {
         let audioInput = try AVCaptureDeviceInput(device: audio)
         guard captureSession.canAddInput(audioInput) else { return false }
         captureSession.addInput(audioInput)
     } catch {
     }
 }
 */
