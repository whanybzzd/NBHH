//
//  TestViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/21.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit
class TestViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor=UIColor.red
        
        self.navigationItem.title=self.params["title"] as? String
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        
    }
    
    override func refreshController() -> Bool {
        
        return true
    }
    override func refreshLoadMore() -> Bool {
    
        return true
    }
    
    override func cellCount() -> Int {
        
        return self.dataArray.count
    }
    override func clickedCell(object: Any, atIndexPath: IndexPath) {
        
        print("我点击了:\(atIndexPath.row)")
    }
    
    override func layoutCellWithData(object: Any, atIndexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: atIndexPath)) as UITableViewCell
       cell.textLabel?.text = String(format: "\(atIndexPath.row)")
        return cell
    }
    
    override func tableViewCellHeightForData(object: Any, atIndexPath: IndexPath) -> CGFloat {
        return 50
    }

}
