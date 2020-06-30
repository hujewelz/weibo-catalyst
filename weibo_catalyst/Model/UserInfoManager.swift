//
//  UserInfoManager.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/30.
//  Copyright © 2020 huluobo. All rights reserved.
//

import Foundation
import Combine
import Request
import Json

final class UserInfoManager {
    static let shared = UserInfoManager()
    
    var user: User? {
        if let cached = _cached { return cached }
        guard let url = dataUrl else { return nil }
        return try? Disk.value(from: url)
    }
    
    private var _cached: User?
    
    static func fetchUserInfo() -> AnyPublisher<User, Error> {
        UserInfoManager.shared.fetchUserInfo()
    }
    
    func fetchUserInfo() -> AnyPublisher<User, Error> {
        return Request(target: API.userInfo).response.$data.tryMap { data in
            guard let data = data else {
                throw RequestError.noData
            }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let user =  try decoder.decode(User.self, from: data)
            self.save(user)
            self._cached = user
            return user
        }
        .receive(on: DispatchQueue.main)
        .eraseToAnyPublisher()
    }
    
    private func save(_ user: User) {
        guard let url = dataUrl else { return }
        try? Disk.save(user, at: url)
    }
    
    private var dataUrl: URL? {
        guard let url = Disk.appCacheUrl else { return nil }
        return url.appendingPathComponent("user.data")
    }
}


enum RequestError: Error {
    case noData
}

