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
}

extension API: RequestTarget {
    var baseURL: String {
        return "https://api.weibo.com/2"
    }
    
    var path: String {
        switch self {
        case .homeTimeLine:
            return "/statuses/home_timeline.json"
        case .userTimeLine:
            return "/statuses/user_timeline.json"
        }
        
    }
    
    var parameters: [String : String]? {
        return ["access_token": AccessTokenManager.shared.token?.accessToken ?? ""]
    }
}
