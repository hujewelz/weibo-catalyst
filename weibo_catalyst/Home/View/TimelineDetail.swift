//
//  CommentView.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/7/2.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI
import Request
import SDWebImageSwiftUI

struct TimelineDetail: View {
    let timeline: TimeLine
    
    var body: some View {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return List {
            Section {
                TimelineCell(timeline: timeline)
            }
            RequestView(Request(target: API.comments(id: timeline.id))) { data in
                ForEach((data != nil ? try? decoder.decode([Comment].self, from: data!, forKey: "comments") : []) ?? []) {
                    comment in
                   CommentCell(comment: comment)
                }
                EmptyView()
            }
        }
    }
}

struct CommentCell: View {
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 8) {
                WebImage(url: URL(string: comment.user.profileImageUrl ?? ""))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .background(Color.gray)
                    .clipShape(Circle())
                VStack(alignment: .leading, spacing: 10) {
                    Text(comment.user.screenName)
                        .foregroundColor(Color.orange)
                        .font(.system(size: 13))
                        .bold()
                    Text(comment.text)
                        .foregroundColor(Color("text1"))
                        .font(.system(size: 14))
                }
            }
            Text(comment.createdAt)
                .foregroundColor(Color.gray)
                .font(.footnote)
        }
        .padding(15)
        .onAppear {
            UITableView.appearance().tableFooterView = UIView()
        }
    }
}

//struct CommentView_Previews: PreviewProvider {
//    static var previews: some View {
//        CommentView()
//    }
//}
