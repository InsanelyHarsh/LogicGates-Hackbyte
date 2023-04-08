//
//  MediaPreview.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import SwiftUI
import UIKit
import AVFoundation

struct MediaPreview:UIViewRepresentable{
    var preview:AVCaptureVideoPreviewLayer
    var size:CGSize
    
    init(preview: AVCaptureVideoPreviewLayer, size: CGSize) {
        self.preview = preview
        self.size = size
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        preview.frame.size = size
        preview.videoGravity = .resizeAspectFill
        view.layer.addSublayer(preview)
        //start running
        return view
    }
    
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
}
