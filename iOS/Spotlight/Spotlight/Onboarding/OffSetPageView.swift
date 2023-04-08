//
//  OffSetPageView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 08/04/23.
//

import Foundation
import SwiftUI

struct OffsetPageView<Content:View>: UIViewRepresentable {
    typealias UIViewType = UIScrollView
    
    @Binding var offSet:CGFloat
    var content:Content
    
    init(offSet:Binding<CGFloat> ,@ViewBuilder content: @escaping ()->Content) {
        self.content = content()
        self._offSet = offSet
    }
    
    func makeCoordinator() -> Coordinator {
        return OffsetPageView.Coordinator(parent: self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView(frame: .zero)
        
        let hostView = UIHostingController(rootView: self.content)
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        let constraint = [
            hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            hostView.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ]
        
        scrollView.addSubview(hostView.view)
        scrollView.addConstraints(constraint)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        scrollView.isPagingEnabled = true
        
        
        scrollView.delegate = context.coordinator
        return scrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        
    }
    
    class Coordinator:NSObject,UIScrollViewDelegate{
        var parent:OffsetPageView
        
        
        init(parent: OffsetPageView) {
            self.parent = parent
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let offSet = scrollView.contentOffset.x
            parent.offSet = offSet
        }
    }
    
}

//struct OffsetPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        GeometryReader{ g in
//            OnBoardingView(screenSize: g.size)
//        }
//    }
//}
