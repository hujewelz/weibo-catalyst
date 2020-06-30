//
//  Timeline.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/28.
//  Copyright © 2020 huluobo. All rights reserved.
//

import SwiftUI

struct TimeLine: Codable, Identifiable {
    let id: Int
    let createdAt: String
    let text: String
    let source: String
    let user: User
    
    var weiboSource: WeiboSource {
        return WeiboSource(value: source)
    }
}

struct User: Codable {
    let id: Int
    let name: String
    let avatarLarge: String
    let location: String
    let description: String
}

struct WeiboSource {
    var link: String
    var source: String

    init(value: String) {
        source = value.match(pattern: ">([\\s\\S]*?)</a>").first ?? ""
        if let endIndex = source.firstIndex(of: "<") {
            source = String(source[source.index(after: source.startIndex)..<endIndex])
        }
        link = value.match(pattern: "(http|https)://[a-z.]+").first ?? ""
    }
}

extension String {
    func match(pattern: String) -> [String] {
        guard let reg = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return []
        }
        let result = reg.matches(in: self, options: [], range: NSRange(location: 0, length: count))
        var array: [String] = []
        for re in result {
            let locationRange = index(startIndex, offsetBy: re.range.location)
            let endRange = index(locationRange, offsetBy: re.range.length)
            let substr = self[locationRange..<endRange]
            array.append(String(substr))
        }
        return array
    }
}
