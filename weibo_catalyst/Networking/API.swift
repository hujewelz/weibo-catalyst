//
//  API.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/29.
//  Copyright © 2020 huluobo. All rights reserved.
//

import Foundation
import Request

enum API {
    case homeTimeLine
    case userTimeLine
    case userInfo
    case comments(id: Int)
}

extension API: RequestTarget {
    var baseURL: String {
        return "https://api.weibo.com"
    }
    
    var path: String {
        switch self {
        case .homeTimeLine:
            return "/2/statuses/home_timeline.json"
        case .userTimeLine:
            return "/2/statuses/user_timeline.json"
        case .userInfo:
            return "/2/users/show.json"
        case .comments:
            return "/2/comments/show.json"
        }
    }
    
    var parameters: [String : String]? {
        switch self{
        case .comments(id: let id):
            return [
                "access_token": AccessTokenManager.shared.token?.accessToken ?? "",
                "id": "\(id)"
            ]
        default:
            return ["access_token": AccessTokenManager.shared.token?.accessToken ?? ""]
        }
    }
}
