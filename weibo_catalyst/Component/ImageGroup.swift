//
//  ImageGroup.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/30.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageGroup: View {
    var body: some View {
        Text("Hello, World!")
    }
}

struct WebImageGroup: View {
    let urls: [String]
    var column: Int = 3
    
    var numberOfRows: Int {
        guard urls.count > 0 else { return 0 }
        return (urls.count - 1) / column + 1
    }
    
    var body: some View {
        return VStack(alignment: .leading, spacing: 8) {
            ForEach(0..<numberOfRows) { row  in
                return HStack {
                    ForEach(0..<self.maxIndex(ofRow: row)) { column in
//                         Text("\(row * self.column + column)")
                        WebImage(url: self.url(at: column, inRow: row))
                            .resizable()
                            .scaledToFill()
                            .background(Color.gray)
                            .frame(width: 120, height: 120)
                            .clipped()
                    }
                }
            }
        }
    }
    
    private func maxIndex(ofRow row: Int) -> Int {
        return max(0, min(column, urls.count - row * self.column))
    }
     
    private func url(at index: Int, inRow row: Int) -> URL? {
        let _index = row * column + index
        if _index >= urls.count { return nil }
        return URL(string: urls[_index])
    }
}

struct ImageGroup_Previews: PreviewProvider {
    static var previews: some View {
        ImageGroup()
    }
}
