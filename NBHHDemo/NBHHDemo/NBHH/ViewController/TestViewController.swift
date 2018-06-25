//
//  TestViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/25.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit
import ZVRefreshing
import HandyJSON
class TestViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title=(self.params["title"] as! String)
        tableView.register(TestTableViewCell.self, forCellReuseIdentifier: "cell")
        

    }
    override func refreshLoadMore() -> Bool {
        
        return false
    }
    override func refreshController() -> Bool {
        
        return true
    }
    
    override func refreshEndController() -> Bool {
        
        return true
    }
    
    override func layoutCellWithData(object: Any, atIndexPath: IndexPath) -> UITableViewCell {
        let model=object as! CustomerList
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell", for: atIndexPath) as! TestTableViewCell
        cell.initSubViewData(model:model)
        return cell
    }
    
    override func clickedCell(object: Any, atIndexPath: IndexPath) {
        
        let model=object as! CustomerList
        print("选择的下标:\(atIndexPath.row)==名字为:\(model.name)")
        
    }
    
    override func tableViewCellHeightForData(object: Any, atIndexPath: IndexPath) -> CGFloat {
        
        return 80.0
    }
    override func refreshHeaderHandler(_ refreshFooter: ZVRefreshFooter?) {
        
        AFNManager.sharedInstance.requestResult(url:HTTPAPI_CUSTOMER_NAME,params:["companyId":"11","id":"32","name":""],method: .post)
            .on(value: { response in
                
                let baseModel=[CustomerList].deserialize(from: (response as AnyObject).description)
                baseModel?.forEach({[weak self]model in
                    
                    self?.dataArray.append(model!)
                })
                self.tableView.refreshHeader?.endRefreshing()
                self.tableView.reloadData()
            })
            .on(failed:{[weak self]error in
                self?.tableView.refreshHeader?.endRefreshing()
                print("错误:\(error)")
            })
            .start()
    }
    
}

