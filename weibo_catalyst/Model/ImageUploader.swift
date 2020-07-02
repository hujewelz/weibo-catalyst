//
//  ImageUploader.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/7/1.
//  Copyright © 2020 huluobo. All rights reserved.
//

import Foundation
import UIKit
import Json

protocol UploadTarget {
    var url: URL { get }
    var parameters: [String: String] { get }
    
}

struct ImageUploader {
    
    static func upload(images: [UIImage], params: [String: String], url: String) {
        guard let request = uploadRequest(urlStr: url, images: images, params: params) else {
            return
        }
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("error: ", error)
                return
            }
            print("json: ", try! Json(data!))
        }.resume()
    }
    
    static private func uploadRequest(urlStr: String, images: [UIImage], params: [String: String]) -> URLRequest? {
        guard let url = URL(string: urlStr) else { return nil }
        let boundary = UUID().uuidString
        
        var request = URLRequest(url: url)
        request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let multipart = MultipartDataFromater(boundary: boundary)
        multipart.append(params: params)
        multipart.append(images: images)
        
        print("body: ", multipart.jsonBody())
        
        request.httpBody = multipart.body
        return request
    }
}

class MultipartDataFromater {
    let boundary: String
    
    init(boundary: String) {
        self.boundary = boundary
    }
    
    /**
    --boundary
    Content-Disposition: form-data; name="key";
        
    value
    --boundary
    Content-Disposition: form-data; name="file"; filename="filename"
    Content-Type: image/jpeg
       
    data
    --boundary--
    */
    
    var body: Data {
        var result = Data()
        result.append(_body)
        result.append("--\(boundary)--\r\n".data(using: .utf8)!)
        return result
    }
    
    private lazy var _body = Data()
    
    func append(params: [String: String]) {
        _body.append(self.body(params: params, boundary: boundary))
    }
    
    func append(images: [UIImage]) {
        for img in images {
            _body.append(self.body(from: img, boundary: boundary))
        }
    }
    
//    var jsonBody: Any {
//        return JSONSerialization.jsonObject(with: self.body, options: [])
//    }
    
    func jsonBody() -> String {
        return String(data: body, encoding: .utf8) ?? ""
    }
    /**
     --boundary
     Content-Disposition: form-data; name="file"; filename="filename"
     Content-Type: image/jpeg
    
     data
     */
    private func body(from image: UIImage, boundary: String) -> Data {
        let filename = "\(UUID().uuidString).jpg"
        var body = Data()
        let header = """
        --\(boundary)
        Content-Disposition: form-data; name="pic"; filename="\(filename)"
        Content-Type: image/jpeg
        
        """
        if let headerData = header.data(using: .utf8) {
            body.append(headerData)
        }
        if let imageData = image.jpegData(compressionQuality: 1) {
            body.append(imageData)
            body.append("\r\n".data(using: .utf8)!)
        }
        return body
    }
    
    /**
     --boundary
     Content-Disposition: form-data; name="key";
     
     value
     --boundary
     Content-Disposition: form-data; name="key";
     
     value
     --boundary
     Content-Disposition: form-data; name="key";
     
     value
     */
    private func body(params: [String: String], boundary: String) -> Data {
        var body = Data()
        for (key, value) in params {
            let _value = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
            let header = """
            --\(boundary)
            Content-Disposition: form-data; name="\(key)";

            \(_value)\r\n
            """
            if let headerData = header.data(using: .utf8) {
                body.append(headerData)
            }
//            let _value = value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? value
//            if let valueData = "\(_value)\r\n".data(using: .utf8) {
//                body.append(valueData)
//            }
        }
        
        return body
    }
}
