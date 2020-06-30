//
//  HomeView.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/28.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI
import Request
import Json

struct HomeView: View {
    
    var body: some View {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return RequestView(Request(target: API.homeTimeLine)) { data in
            List {
                ForEach(data != nil ? try! decoder.decode(WeiboResult<[TimeLine]>.self, from: data!).value : []) { timeline in
                    TimelineCell(timeline: timeline)
                }
            }
            LoadingIndicator()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
