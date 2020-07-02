//
//  PostView.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/28.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI
import Request

struct PostView: View {
    @State var text = ""
    @State var isPresented = false
    @State var images: [UIImage] = []
    
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
                    self.isPresented = true
                }) {
                    Image(systemName: "photo.fill")
                    Text("图片")
                }.sheet(isPresented: $isPresented) {
                    ImagePicker { image in
                        self.images.append(image)
                    }
                }
                
                Button(action: {
                    self.post()
                }) {
                    Text("发送")
                }
                .frame(width: 80, height: 38)
                .foregroundColor(Color.white)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            
            // images
            if !images.isEmpty {
                HStack {
                    ForEach(0..<images.count, id: \.self) { idx in
                        Image(uiImage: self.images[idx])
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                }.padding(.top, 15)
            }
            Spacer()
        }
        .buttonStyle(PlainButtonStyle())
        .padding(30)
        .foregroundColor(Color("text1"))
    }
    
    private func post() {
        print("Text: ", text)
        let params = [
            "access_token": AccessTokenManager.shared.token?.accessToken ?? "",
            "status": text
        ]
        ImageUploader.upload(images: images,
                             params: params,
                             url: "https://api.weibo.com/2/statuses/share.json")
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
