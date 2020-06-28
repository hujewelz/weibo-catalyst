//
//  PostView.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/28.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI

struct PostView: View {
    @State var text = ""
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            HStack {
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "xmark")
                }
            }
            Text("有什么新鲜事告诉大家?")
                .font(.title)
                .italic()
                .padding(.bottom, 10)
            
            TextView(text: $text)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .frame(maxHeight: 120)
            
            HStack(spacing: 16) {
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "paperclip.circle.fill")
                    Text("图片")
                }
                
                Button(action: {
                    
                }) {
                    Text("发送")
                }
                .frame(width: 80, height: 38)
                .foregroundColor(Color.white)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            Spacer()
        }.padding(30)
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}

struct TextView: UIViewRepresentable {
    @Binding var text: String
    var onEditingChanged: ((Bool) -> Void)?
    var onCommit: ((Bool) -> Void)?
    
    func makeUIView(context: Context) -> UITextView {
        let  textView = UITextView()
        textView.text = text
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.isScrollEnabled = false
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        
    }
}
