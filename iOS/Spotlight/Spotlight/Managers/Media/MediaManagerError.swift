//
//  MediaManagerError.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation


import AVFoundation
import CoreImage
import Combine

enum MediaManagerError:Error{
    case unknownError
    case accessNotGranted
}




class MediaManager: NSObject{
//    @Published var frame: CGImage?
    private(set) var frame = PassthroughSubject<CGImage?,Never>()
    
    @Published private(set) var videoPermissionGranted = false
    @Published private(set) var audioPermissionGranted = false
    
    private let captureSession = AVCaptureSession()
    private let sessionQueue = DispatchQueue(label: "sessionQueue")
    private let context = CIContext()

    var rearCamera:AVCaptureDevice?
    var frontCamera:AVCaptureDevice?
    
    var rearCameraInput:AVCaptureDeviceInput?
//    var currentCameraPosition: AVCaptureDevice.Position = .back
    
    var audioDevice:AVCaptureDevice?
    var frontCameraInput:AVCaptureDeviceInput?
    
    var audioInput:AVCaptureDeviceInput?
    override init() {
        super.init()
    }
    
    func checkPermission(for mediaType:AVMediaType) {
        switch AVCaptureDevice.authorizationStatus(for: mediaType) {
            case .authorized: // The user has previously granted access to the camera.
            if(mediaType == .video){
                videoPermissionGranted = true
            }
            if(mediaType == .audio){
                audioPermissionGranted = true
            }
                
            case .notDetermined: // The user has not yet been asked for camera access.
                requestPermission(for: mediaType)
                
        // Combine the two other cases into the default case
        default:
            if(mediaType == .video){
                videoPermissionGranted = false
            }
            if(mediaType == .audio){
                audioPermissionGranted = false
            }
        }
    }
    
    private func requestPermission(for mediaType:AVMediaType) {
        // Strong reference not a problem here but might become one in the future.
        AVCaptureDevice.requestAccess(for: mediaType) { [unowned self] granted in
            if(mediaType == .video){
                videoPermissionGranted = granted
            }
            if(mediaType == .audio){
                audioPermissionGranted = granted
            }
        }
    }
    
    func configureSession(){
        
        sessionQueue.async { [unowned self] in
//            setupCaptureSession()
//            setupAudioCaptureSession()
            self.captureSession.startRunning()
        }
        
    }
    
    
    
//    private func setupCaptureSession() {
//        let videoOutput = AVCaptureVideoDataOutput()
//
//        guard videoPermissionGranted else { return }
//
//        guard let videoDevice = AVCaptureDevice.default(.builtInWideAngleCamera,for: .video, position: .back) else { return }
//        guard let videoDeviceInput = try? AVCaptureDeviceInput(device: videoDevice) else { return }
//        guard captureSession.canAddInput(videoDeviceInput) else { return }
//        captureSession.addInput(videoDeviceInput)
//
//        videoOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "sampleBufferQueue"))
//        captureSession.addOutput(videoOutput)
//
//        videoOutput.connection(with: .video)?.videoOrientation = .portrait
//    }
    
    
//    private func setupAudioCaptureSession(){
//        let audioOutput = AVCaptureAudioDataOutput()
////        AVCaptureMetadataOutput()
//        guard audioPermissionGranted else { return }
//
//        guard let audioDevice = AVCaptureDevice.default(for: .audio) else { return }
//        guard let audioDeviceInput = try? AVCaptureDeviceInput(device: audioDevice) else { return }
//        guard captureSession.canAddInput(audioDeviceInput) else { return }
//        captureSession.addInput(audioDeviceInput)
//
//        audioOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "SampleAudioDelegate"))
//        captureSession.addOutput(audioOutput)
//
//        audioOutput.connection(with: .audio)
//    }
    
    func setupVideoCapture(){
        let session = AVCaptureDevice.DiscoverySession.init(deviceTypes:[.builtInWideAngleCamera, .builtInMicrophone], mediaType: AVMediaType.video, position: .back)
        
        let cameras = session.devices.compactMap{$0}
        
        for camera in cameras {
            
            if camera.position == .front {
                self.frontCamera = camera
            }
            if camera.position == .back {
                self.rearCamera = camera

                try? camera.lockForConfiguration()
                camera.focusMode = .continuousAutoFocus
                camera.unlockForConfiguration()
            }
        }
        
        
    }
    
    func configure(){
//        guard let captureSession = self.captureSession else {
//            return
//        }

        if let rearCamera = self.rearCamera {
            
            self.rearCameraInput = try? AVCaptureDeviceInput(device: rearCamera)
            if captureSession.canAddInput(self.rearCameraInput!) {
                captureSession.addInput(self.rearCameraInput!)
//                self.currentCameraPosition = .rear
            } else {
                return
            }
            
        } else if let frontCamera = self.frontCamera {
            
            self.frontCameraInput = try? AVCaptureDeviceInput(device: frontCamera)
            if captureSession.canAddInput(self.frontCameraInput!) {
                captureSession.addInput(self.frontCameraInput!)
//                self.currentCameraPosition = .front
            } else {
                return
            }
            
        } else {
            return
        }

        // Add audio input
        if let audioDevice = self.audioDevice {
            self.audioInput = try? AVCaptureDeviceInput(device: audioDevice)
            if captureSession.canAddInput(self.audioInput!) {
                captureSession.addInput(self.audioInput!)
            } else {
                return
            }
        }
    }
}


extension MediaManager: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let cgImage = imageFromSampleBuffer(sampleBuffer: sampleBuffer) else { return }
        
        // All UI updates should be/ must be performed on the main queue.
        DispatchQueue.main.async { [unowned self] in
            self.frame.send(cgImage)
        }
        
    }
    
    private func imageFromSampleBuffer(sampleBuffer: CMSampleBuffer) -> CGImage? {
        guard let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return nil }
        let ciImage = CIImage(cvPixelBuffer: imageBuffer)
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else { return nil }
        
        return cgImage
    }
    
}
