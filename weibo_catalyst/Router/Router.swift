//
//  Router.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/28.
//  Copyright © 2020 huluobo. All rights reserved.
//

import UIKit
import SwiftUI

class Router {
    private var window: UIWindow!
    
    static let shared = Router()
    
    func start(_ window: UIWindow) {
        self.window = window
       
        if AccessTokenManager.shared.token == nil {
            window.rootViewController = AuthorizationViewController()
        } else {
            switchToMain()
        }
    }
    
    func switchToMain() {
        #if targetEnvironment(macCatalyst)
        let rightNavVC = UINavigationController(rootViewController: UIHostingController(rootView: ContentView()))
        rightNavVC.navigationBar.isHidden = true
        let splitViewController = SplitViewController()
        splitViewController.viewControllers = [MasterViewController(), rightNavVC]
        splitViewController.primaryBackgroundStyle = .sidebar
        splitViewController.maximumPrimaryColumnWidth = 180
        splitViewController.minimumPrimaryColumnWidth = 180
        window.rootViewController = splitViewController
        window.windowScene?.titlebar?.titleVisibility = .hidden
        #else
        window.rootViewController = UIHostingController(rootView: ContentView())
        #endif
    }
}
