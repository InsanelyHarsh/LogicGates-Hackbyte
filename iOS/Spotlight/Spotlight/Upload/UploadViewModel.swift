//
//  UploadViewModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation
import SwiftUI
import Combine

class UploadViewModel:ObservableObject{
    private let mediaManager:MediaManager = MediaManager()
    
    var cancellable = Set<AnyCancellable>()
    @Published var feedImage:Image = Image(systemName: "gear")
    @Published var isGranted:Bool = false
    
    init(){
        checkPermission()
        handlePermission()
    }
    
    func checkPermission(){
        
        mediaManager.checkPermission(for: .video)
        mediaManager.checkPermission(for: .audio)
        
        mediaManager.configureSession()
    }
    
    func handlePermission(){
        mediaManager.frame.sink {[unowned self] image in
            if(image != nil){
                self.feedImage = Image(image!, scale: 1.0, orientation: .up, label: Text("Feed"))
            }
        }
        .store(in: &cancellable)
    }
}
