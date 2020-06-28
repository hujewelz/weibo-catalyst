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
}

struct User: Codable {
    let id: Int
    let name: String
    let avatar: String
    let location: String
    let description: String
}

let testUser = User(id: 1, name: "UI 设计", avatar: "", location: "", description: "")

let testData = (0..<5).map {
    TimeLine(id: $0,
             createdAt: "今天 15:33",
             text: "#插画# 插画家 Jaime Jacob 创作的商业插图系列 ​​​​",
             source: "微博 weibo.com",
             user: testUser)
}
