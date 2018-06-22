//
//  BaseTableViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/22.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class BaseTableViewController: BaseRefreshViewController,UITableViewDelegate,UITableViewDataSource {

    lazy var tableView:UITableView=UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView=UITableView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        tableView.tableHeaderView=UIView.init()
        tableView.tableFooterView=UIView.init()
        tableView.delegate=self
        tableView.dataSource=self
        self.view.addSubview(tableView)
        
    }

}

extension BaseTableViewController{
    
    //私有的高度方法
   @objc func tableViewCellHeightForData(object:Any,atIndexPath:IndexPath) -> CGFloat {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellCount()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell=self.layoutCellWithData(object: AnyObject.self, atIndexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let rowHeight=self.tableViewCellHeightForData(object: AnyObject.self, atIndexPath: indexPath)
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.clickedCell(object: AnyObject.self, atIndexPath: indexPath)
    }
}
