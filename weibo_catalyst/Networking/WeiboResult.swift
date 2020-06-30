//
//  WeiboResult.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/29.
//  Copyright © 2020 huluobo. All rights reserved.
//

import Foundation

struct WeiboResult<Value>: Decodable where Value: Decodable {
    var statuses: Value
    
    var value: Value {
        return statuses
    }
}
