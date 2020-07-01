//
//  TimelineToolbar.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/30.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI

struct TimelineToolbar: View {
    @State var isFavorited = false
    @State var repostsCount = 0
    @State var commentsCount = 0
    @State var attitudesCount = 0
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack {
                Button(action: {
                    self.isFavorited.toggle()
                }) {
                    HStack {
                    Image(systemName: isFavorited ? "star.fill" : "star")
                    Text("收藏")
                        .font(.footnote)
                    }
                }.frame(maxWidth: .infinity)
                
                Button(action: {
                    
                }) {
                    HStack {
                    Image(systemName: "square.and.arrow.up")
                    Text(repostsCount > 0 ? "\(repostsCount)" : "转发")
                        .font(.footnote)
                    }
                }
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                
                Button(action: {
                    
                }) {
                    HStack {
                    Image(systemName: "ellipses.bubble")
                    Text(commentsCount > 0 ? "\(commentsCount)" : "评论")
                        .font(.footnote)
                    }
                }.frame(maxWidth: .infinity)
                
                Button(action: {
                    
                }) {
                    HStack {
                    Image(systemName: "hand.thumbsup")
                    Text(attitudesCount > 0 ? "\(attitudesCount)" : "点赞")
                        .font(.footnote)
                    }
                }.frame(maxWidth: .infinity)
            }
        }
        .frame(height: 40)
        .foregroundColor(Color.gray)
        .buttonStyle(PlainButtonStyle())
//        .background(Color.pink)
    }
}

struct TimelineToolbar_Previews: PreviewProvider {
    static var previews: some View {
        TimelineToolbar(isFavorited: true)
    }
}
