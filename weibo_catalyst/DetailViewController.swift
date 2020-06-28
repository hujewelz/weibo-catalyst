//
//  DetailViewController.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/28.
//  Copyright © 2020 huluobo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupMacToolbar()
    }
    
    func setupMacToolbar() {
        #if targetEnvironment(macCatalyst)
        guard let windowSceen = view.window?.windowScene else { return }
        let toolbar = NSToolbar(identifier: "DetailToolbar")
        toolbar.delegate = self
        windowSceen.titlebar?.toolbar = toolbar
        #endif
    }
}

#if targetEnvironment(macCatalyst)
extension DetailViewController: NSToolbarDelegate {
    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.goback, .flexibleSpace, .new]
    }
    
    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier] {
        return [.goback, .flexibleSpace, .new]
    }
    
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem? {
        let toolbarItem = NSToolbarItem(itemIdentifier: itemIdentifier)
        toolbarItem.isBordered = true
        toolbarItem.target = self
        toolbarItem.action = #selector(toolbarItemClicked(_:))
        if itemIdentifier == .goback {
            toolbarItem.tag = 1
            toolbarItem.image = UIImage(systemName: "chevron.left")
        } else if itemIdentifier == .new {
            toolbarItem.image = UIImage(systemName: "pencil.and.outline")
            toolbarItem.tag = 2
        }
        return toolbarItem
    }
    
    @objc private func toolbarItemClicked(_ sender: NSToolbarItem) {
        if sender.tag == 1 {
            navigationController?.popViewController(animated: true)
        } else if sender.tag == 2 {
            
        }
    }

}

private extension NSToolbarItem.Identifier {
    static let goback = NSToolbarItem.Identifier("goback")
    static let new = NSToolbarItem.Identifier("new")
}
#endif
