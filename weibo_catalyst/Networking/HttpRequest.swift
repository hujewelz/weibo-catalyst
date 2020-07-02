//
//  HttpRequest.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/30.
//  Copyright © 2020 huluobo. All rights reserved.
//

import Foundation
import SwiftUI
import Request
import Json


class HttpRequest<Value>: ObservableObject where Value: Decodable {
    @Published var data: Value?
    
    let target: RequestTarget
    
    init(target: RequestTarget) {
        self.target = target
        request()
    }
    
    func request() {
        Request(target: target).onData { data in
            DispatchQueue.main.async {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let result = try decoder.decode(WeiboResult<Value>.self, from: data)
                    self.data = result.value
                } catch {
                    self.data = nil
                }
            }
        }.onError { error in
            print("Error: ", try! Json(error.error!))
            DispatchQueue.main.async {
                self.data = nil
            }
        }.call()
    }
}

enum NetworkError: Error {
    case dataFormateError
}

extension JSONDecoder {
    func decode<T>(_ type: T.Type, from data: Data, forKey key: String) throws -> T where T : Decodable {
        guard let json = try? JSONSerialization.jsonObject(with: data, options: [])
            , let dict = json as? [String: Any]
            , let value = dict[key] else {
                throw NetworkError.dataFormateError
        }
        guard let valueData = try? JSONSerialization.data(withJSONObject: value, options: []) else {
            throw NetworkError.dataFormateError
        }
        return try decode(type, from: valueData)
    }
}
