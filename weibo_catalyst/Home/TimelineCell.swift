//
//  TimelineCell.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/28.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI

struct TimelineCell: View {
    let timeline: TimeLine
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            Image(timeline.user.avatar)
                .resizable()
                .frame(width: 60, height: 60)
                .background(Color.pink)
                .clipShape(Circle())
                
            VStack(alignment: .leading, spacing: 8) {
                Text(timeline.user.name)
                    .font(.title)
                HStack {
                    Text(timeline.createdAt)
                    .font(.footnote)
                    .foregroundColor(Color.gray)
                    
                    Text("来自 \(timeline.source)")
                        .font(.footnote)
                        .foregroundColor(Color.gray)
                }
                Spacer()
                Text(timeline.text)
            }
        }.padding(15)
    }
}

struct TimelineCell_Previews: PreviewProvider {
    static var previews: some View {
        TimelineCell(timeline: testData[0])
    }
}
