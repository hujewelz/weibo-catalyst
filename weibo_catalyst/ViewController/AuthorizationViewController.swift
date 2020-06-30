//
//  AuthorizationViewController.swift
//  weibomacOSApp
//
//  Created by huluobo on 2020/6/1.
//  Copyright © 2020 huluobo. All rights reserved.
//

import UIKit
import WebKit
import Request
import Json

class AuthorizationViewController: UIViewController {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        guard let url = URL(string: WeiboConstant.auth) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func reload() {
        guard let url = URL(string: WeiboConstant.auth) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func fetchAccessToken(code: String) {
        Request {
            Url("https://api.weibo.com/oauth2/access_token")
            Method(.post)
            Header.ContentType(.json)
            Query([
                "client_id": WeiboConstant.appKey,
                "client_secret": WeiboConstant.appSecret,
                "grant_type": "authorization_code",
                "redirect_uri": WeiboConstant.redirectUri,
                "code": String(code),
                ])
        }.onJson { json in
            DispatchQueue.main.async {
                print("JSON:", json)
                guard let data = json.data else {
                    self.reload()
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let token = try decoder.decode(AccessToken.self, from: data)
                    try AccessTokenManager.shared.save(token)
                    Router.shared.switchToMain()
                } catch let error {
                    print("error: ", error)
                    self.reload()
                }
            }
        }.onError { error in
            self.reload()
        }.call()
    }
}

extension AuthorizationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard let urlStr = webView.url?.absoluteString
            , let query = urlStr.split(separator: "?").last
            , query.hasPrefix("code")
            , let code = query.split(separator: "=").last else {
            return
        }

        fetchAccessToken(code: String(code))
    }
}
