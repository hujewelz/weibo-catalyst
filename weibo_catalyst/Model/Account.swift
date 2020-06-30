//
//  Account.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/29.
//  Copyright © 2020 huluobo. All rights reserved.
//

import Foundation
import Json

final class AccessTokenManager {
    static let shared = AccessTokenManager()
    
    private init() {}
    
    var token: AccessToken? {
        if _token != nil {
            return _token!.isExpiresed ? nil : _token
        }
        guard let dataUrl = dataRootUrl?.appendingPathComponent("accesstoken.data")
            , let token: AccessToken = try? Disk.value(from: dataUrl) else { return nil }
        if token.isExpiresed { return nil }
        _token = token
        return token
    }
    
    private var _token: AccessToken?
    
    private var dataRootUrl: URL? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return nil
        }
        return url.appendingPathComponent("jewelz.weiboclient", isDirectory: true)
    }
    
    
    func save(_ token: AccessToken) throws {
        let data = try JSONEncoder().encode(token)
        guard let rootUrl = dataRootUrl else {
            throw SaveFileError.pathDoesNotExists
        }
        let dataUrl = rootUrl.appendingPathComponent("accesstoken.data")
        try Disk.save(data, at: dataUrl)
    }
}

struct AccessToken: Codable {
    var accessToken: String
    var expiresIn: Double
    var expiresAt: Double
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try container.decode(String.self, forKey: .accessToken)
        expiresIn = try container.decode(Double.self, forKey: .expiresIn)
        expiresAt = Date().timeIntervalSince1970 + expiresIn
    }
    
    var isExpiresed: Bool {
        return Date().timeIntervalSince1970 > expiresAt
    }
}

enum SaveFileError: Error {
    case pathDoesNotExists
}
