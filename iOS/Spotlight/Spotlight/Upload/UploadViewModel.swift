//
//  UploadViewModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation
import SwiftUI
import Combine
import AVKit
//class UploadViewModel:ObservableObject{
//    private let mediaManager:MediaManager = MediaManager()
//
//    var cancellable = Set<AnyCancellable>()
//    @Published var feedImage:Image = Image(systemName: "gear")
//    @Published var isGranted:Bool = false
//
//    init(){
//        checkPermission()
//        handlePermission()
//    }
//
//    func checkPermission(){
//
//        mediaManager.checkPermission(for: .video)
//        mediaManager.checkPermission(for: .audio)
//
//        mediaManager.configureSession()
//    }
//
//    func handlePermission(){
//        mediaManager.frame.sink {[unowned self] image in
//            if(image != nil){
//                self.feedImage = Image(image!, scale: 1.0, orientation: .up, label: Text("Feed"))
//            }
//        }
//        .store(in: &cancellable)
//    }
//}

class UploadViewModel:ObservableObject{
    private let mediaManager:Media = Media()
    
    var cancellable = Set<AnyCancellable>()
    @Published var feedImage:Image = Image(systemName: "gear")
    @Published var isGranted:Bool = false
    @Published var feed:AVCaptureVideoPreviewLayer?
    
    @Published var isRecording:Bool = false
    var preview = AVCaptureVideoPreviewLayer() //todo....
    
    init(){
        startCamera()
    }

    
    func startCamera(){
        if(mediaManager.checkPermission(for: .audio) && mediaManager.checkPermission(for: .video)){
            self.isGranted = true
            
            if(mediaManager.initVideoRecorder()){
                mediaManager.$previewLayer
                    .sink { [unowned self] preivew in
                        self.feed = preivew
                    }
                    .store(in: &cancellable)
            }
            else{
                //show alert
                print("failed")
            }
        }else{
            //show alert
        }
    }
    
    func flipCamera(){
        mediaManager.changePosition()
        
        startCamera()
    }
}
