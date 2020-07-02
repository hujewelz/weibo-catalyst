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
                ForEach((data != nil ? try? decoder.decode([TimeLine].self, from: data!, forKey: "statuses") : []) ?? []) {
                    timeline in
                    ZStack { // to hide navigationLink disclosure indicator
                        NavigationLink(destination: TimelineDetail(timeline: timeline)) {
                            EmptyView()
                        }
                        .hidden()
                        TimelineCell(timeline: timeline)
                    }
                }
            }
            
            LoadingIndicator()
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
        }
    }
    
    func test() {
        Request(target: API.homeTimeLine).onJson { json in
            print(json)
        }.onError{ error in
            if let data = error.error {
                print("ERROR: ", try! Json(data))
            }
        }.call()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
