//
//  CustomTagView.swift
//  Spotlight
//
//  Created by Harsh Yadav on 09/04/23.
//

import SwiftUI





struct CustomTagView: View {
    @Binding var rows: [[Tag]]
    let removeTagAction:((_ id:String)->Void)
    var body: some View {
        
        VStack(alignment: .leading, spacing: 4){
            ForEach(rows, id:\.self){ rows in
                HStack(spacing: 6){
                    ForEach(rows){ row in
                        Text(row.name)
                            .font(.system(size: 16))
                            .padding(.leading, 14)
                            .padding(.trailing, 30)
                            .padding(.vertical, 8)
                            .background(
                                ZStack(alignment: .trailing){
                                    Capsule()
                                        .fill(.gray.opacity(0.3))
                                    Button{
                                        removeTagAction(row.id)
                                    } label:{
                                        Image(systemName: "xmark")
                                            .frame(width: 15, height: 15)
                                            .padding(.trailing, 8)
                                            .foregroundColor(.red)
                                    }
                                }
                            )
                    }
                }
                .frame(height: 28)
                .padding(.bottom, 10)
            }
        }
        .padding(24)
        
        Spacer()
    }
}


struct CustomTagView_Previews: PreviewProvider {
    static var previews: some View {
        CustomTagView(rows: .constant([[]])) { id in
            
        }
    }
}
