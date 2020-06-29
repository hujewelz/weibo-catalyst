//
//  WeiboConstant.swift
//  WeibomaOSApp
//
//  Created by huluobo on 2020/5/29.
//  Copyright © 2020 huluobo. All rights reserved.
//

import Foundation

struct WeiboConstant {
    static let appKey = "1505150795"
    static let appSecret = "17fc8c2298f70bcea1e8b891ca42998a"
    static let redirectUri = "https://api.weibo.com/oauth2/default.html"
    static let auth = "https://api.weibo.com/oauth2/authorize?client_id=\(appKey)&response_type=code&redirect_uri=\(redirectUri)"
}
