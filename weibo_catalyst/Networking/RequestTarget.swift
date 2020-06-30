//
//  RequestTarget.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/29.
//  Copyright © 2020 huluobo. All rights reserved.
//

import Foundation
import Request

protocol RequestTarget {
    var baseURL: String { get }
    var path: String { get }
    var method: MethodType { get }
    var parameters: [String: String]? { get }
    var headers: [HeaderParam] { get }
}

extension RequestTarget {
    var urlString: String {
        var urlStr: String
        if baseURL.last == "/" || path.first == "/" {
            urlStr = "\(baseURL)\(path)"
        } else {
            urlStr = "\(baseURL)/\(path)"
        }
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? baseURL
        return urlStr
    }
    
    var method: MethodType {
        return .get
    }
    
    var parameters: [String: String]? { return nil }
    
    var headers: [HeaderParam] {
        return [Header.ContentType(.json)]
    }
}

extension AnyRequest {
    init(target: RequestTarget) {
        if let parameters = target.parameters {
            let param: RequestParam = target.method == .post
                ? Body(parameters)
                : Query(parameters)
            self.init { () -> RequestParam in
                Url(target.urlString)
                Method(target.method)
                Header.ContentType(.json)
                param
            }
        } else {
            self.init { () -> RequestParam in
                Url(target.urlString)
                Method(target.method)
                Header.ContentType(.json)
            }
        }
    }
}
