//
//  ContentView.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/28.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        #if targetEnvironment(macCatalyst)
        return MacContentView()
        #else
        return iOSContentView()
        #endif
    }
}

struct MacContentView: View {
    var body: some View {
        HomeView(/*request: .init(target: API.homeTimeLine)*/)
    }
}

struct DetailView: View {
    var body: some View {
        VStack {
            Text("Detail")
            NavigationLink(destination: Text("1").navigationBarHidden(true)) {
                Text("PUSH")
            }
        }
        .navigationBarHidden(true)
    }
}

struct iOSContentView: View {
    var body: some View {
        TabView {
            Text("1")
                .font(.largeTitle)
                .tabItem {
                    Image(systemName: "house.fill")
                }.tag(1)
            
            Text("2")
                .font(.largeTitle)
                .foregroundColor(.red)
                .tabItem {
                    Image(systemName: "message.circle.fill")
                }.tag(2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
