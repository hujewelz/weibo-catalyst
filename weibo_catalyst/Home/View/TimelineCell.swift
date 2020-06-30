//
//  TimelineCell.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/28.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct TimelineCell: View {
    let timeline: TimeLine
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            WebImage(url: URL(string: timeline.user.avatarLarge))
                .resizable()
                .frame(width: 60, height: 60)
                .background(Color.gray)
                .clipShape(Circle())
                
            VStack(alignment: .leading, spacing: 8) {
                Text(timeline.user.name)
                    .font(.system(size: 17))
                    .bold()
                HStack {
                    Text(timeline.createdAt)
                    .font(.system(size: 14))
                    .foregroundColor(Color.gray)
                    
                    Text("来自 \(timeline.weiboSource.source)")
                        .font(.system(size: 14))
                        .foregroundColor(Color.gray)
                        .onTapGesture {
                            guard let url = URL(string: self.timeline.weiboSource.link) else { return }
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                    }
                }
                Spacer()
                Text(timeline.text)
            }
        }.padding(15)
    }
}

struct TimelineCell_Previews: PreviewProvider {
    static var previews: some View {
        TimelineCell(timeline:
            TimeLine(id: 0, createdAt: "", text: "", source: "", user:
                User(id: 1, name: "", avatarLarge: "", location: "", description: "")))
    }
}
