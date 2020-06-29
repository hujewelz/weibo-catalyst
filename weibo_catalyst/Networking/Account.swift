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
        guard let dataUrl = dataRootUrl?.appendingPathComponent("/accesstoken.data")
            , let data = try? Data(contentsOf: dataUrl),
            let token = try? JSONDecoder().decode(AccessToken.self, from: data) else { return nil }
        if token.isExpiresed { return nil }
        _token = token
        return token
    }
    
    private var _token: AccessToken?
    
    private var dataRootUrl: URL? {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            return nil
        }
        return url.appendingPathComponent("jewelz.weiboclient")
    }
    
    
    func save(_ token: AccessToken) throws {
        let data = try JSONEncoder().encode(token)
        guard let rootUrl = dataRootUrl else {
            throw SaveFileError.pathDoesNotExists
        }
        let dataUrl = rootUrl.appendingPathComponent("accesstoken.data")
        if !FileManager.default.fileExists(atPath: dataUrl.absoluteString) {
            try FileManager.default.createDirectory(at: rootUrl, withIntermediateDirectories: true)
        }
        print("Data path: ", dataUrl)
        try data.write(to: dataUrl, options: [Data.WritingOptions.atomic])
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
        print("expiresAt: ", expiresAt)
    }
    
    var isExpiresed: Bool {
        return Date().timeIntervalSince1970 > expiresAt
    }
}

enum SaveFileError: Error {
    case pathDoesNotExists
}
