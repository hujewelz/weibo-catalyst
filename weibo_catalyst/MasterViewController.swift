//
//  MasterViewController.swift
//  weibo_catalyst
//
//  Created by huluobo on 2020/6/28.
//  Copyright © 2020 huluobo. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var menus: [MenuItem] = [
        .init(icon: "house.fill", title: "Home"),
        .init(icon: "message.circle.fill", title: "Message")]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let menu = menus[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.imageView?.image = UIImage(systemName: menu.icon)
        cell.textLabel?.text = menu.title
        return cell
    }
}

struct MenuItem {
    let icon: String
    let title: String
}
