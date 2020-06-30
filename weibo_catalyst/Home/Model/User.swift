//
//  User.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/30.
//  Copyright © 2020 huluobo. All rights reserved.
//

import Foundation
import Request
import Json

struct User: Codable {
    let id: Int
    let name: String
    let screenName: String
    /// 用户头像地址（大图），180×180像素
    let avatarLarge: String
    let location: String
    let description: String
    /// 用户头像地址（中图），50×50像素
    var profileImageUrl: String?
    /// 粉丝数
    var followersCount = 0
    /// 关注数
    var friendsCount = 0
    /// 微博数
    var statusesCount = 0
}

struct UserInfo {
    static func fetchUserInfo() {
//        Request(target: API.userInfo).on
    }
}
