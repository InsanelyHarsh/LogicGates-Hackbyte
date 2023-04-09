//
//  NewPostViewModel.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import Foundation
import UIKit

struct Tag: Identifiable, Hashable{
    var id = UUID().uuidString
    var name: String
    var size: CGFloat = 0
}

enum NewPostMediaOptions:CaseIterable{
    case camera
    case upload
    
    var title:String{
        switch self {
        case .camera:
            return "Camera"
        case .upload:
            return "Upload"
        }
    }
}

class NewPostViewModel:ObservableObject{
    @Published var rows: [[Tag]] = []
    @Published var tags: [Tag] = []
    @Published var tagText = ""
    
    @Published var postTitle:String = ""
    @Published var postDescription:String = ""
    
    @Published var selectedMediaOption:NewPostMediaOptions!
//    @Published var mediaOptions = ["Camera","Upload"]
    init(){
//        getTags()
    }
    
    func makePost(){
        //
    }
    
    func addTag(){
        tags.append(Tag(name: tagText))
        tagText = ""
        getTags()
    }
    
    func removeTag(by id: String){
        tags = tags.filter{ $0.id != id }
        getTags()
    }
    
    
    func getTags(){
        var rows: [[Tag]] = []
        var currentRow: [Tag] = []
        
        var totalWidth: CGFloat = 0
        
        let screenWidth = UIScreen.screenWidth - 10
        let tagSpaceing: CGFloat = 56
        
        if !tags.isEmpty{
            
            for index in 0..<tags.count{
                self.tags[index].size = tags[index].name.getSize()
            }
            
            tags.forEach{ tag in
                
                totalWidth += (tag.size + tagSpaceing)
                
                if totalWidth > screenWidth{
                    totalWidth = (tag.size + tagSpaceing)
                    rows.append(currentRow)
                    currentRow.removeAll()
                    currentRow.append(tag)
                }else{
                    currentRow.append(tag)
                }
            }
            
            if !currentRow.isEmpty{
                rows.append(currentRow)
                currentRow.removeAll()
            }
            
            self.rows = rows
        }else{
            self.rows = []
        }
        
    }
}
