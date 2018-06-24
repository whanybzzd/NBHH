//
//  TestViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/21.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit
import ZVRefreshing
class TestViewController: BaseTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let model=object as! CustomerList
        print("我点击了:\(atIndexPath.row)==name:\(model.name)")
    }
    
    override func layoutCellWithData(object: Any, atIndexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: "cell", for: atIndexPath)) as UITableViewCell
        let model=object as! CustomerList
       cell.textLabel?.text = String(format: "\(model.name)")
        return cell
    }
    
    override func tableViewCellHeightForData(object: Any, atIndexPath: IndexPath) -> CGFloat {
        return 50
    }

//重写父类方法
    override func refreshHeaderHandler(_ refreshFooter: ZVRefreshFooter?) {
        
        print("头部刷新")
        AFNManager.sharedInstance.requestResult(url:HTTPAPI_CUSTOMER_NAME,params:["companyId":"11","id":"21","name":""],method: .post)
            .on(value: { response in
                self.dataArray.removeAll()
                let baseModel=[CustomerList].deserialize(from: (response as AnyObject).description)
                
                baseModel!.forEach({ (model) in
                    
                    self.dataArray.append(model!)
                })
                self.tableView.reloadData()
                self.tableView.refreshHeader?.endRefreshing()
                
            })
            .on(failed:{error in
                
                print("错误:\(error)")
                self.tableView.refreshHeader?.endRefreshing()
                self.dataArray.removeAll()
            })
            .start()
        
    }
    
    
}
