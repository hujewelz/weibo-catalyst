//
//  File.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/30.
//  Copyright © 2020 huluobo. All rights reserved.
//

import Foundation

struct Disk {
    static func save<T>(_ value: T,  at url: URL) throws where T: Encodable {
        let data = try JSONEncoder().encode(value)
        try save(data, at: url)
    }
    
    static func save(_ data: Data, at url: URL) throws {
        if !FileManager.default.fileExists(atPath: url.absoluteString) {
            try FileManager.default.createDirectory(at: url.deletingLastPathComponent(), withIntermediateDirectories: true)
        }
        try data.write(to: url, options: [Data.WritingOptions.atomic])
    }
    
    static func data(from url: URL) throws -> Data {
        return try Data(contentsOf: url)
    }
    
    static func value<T>(from url: URL) throws -> T where T: Decodable {
        let data = try self.data(from: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}

