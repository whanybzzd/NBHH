//
//  BaseTableViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/22.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit
import ZVRefreshing
import HandyJSON
import SwiftyJSON
class BaseTableViewController: BaseRefreshViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView:UITableView=UITableView()
    private var flatHeader: ZVRefreshFlatHeader?
    private var flatBackFooter: ZVRefreshBackFlatFooter?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView=UITableView(frame: CGRect(x: 0, y: height!, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-height!), style: .plain)
        tableView.tableHeaderView=UIView.init()
        tableView.tableFooterView=UIView.init()
        tableView.delegate=self
        tableView.dataSource=self
        self.view.addSubview(tableView)
        
        //刷新
        if self.refreshController(){
            
            // MARK: Header
            flatHeader = ZVRefreshFlatHeader(target: self, action: #selector(refreshHeaderHandler(_:)))
            flatHeader?.setTitle("下拉开始刷新数据", for: .idle)
            flatHeader?.setTitle("释放开始刷新数据", for: .pulling)
            flatHeader?.setTitle("正在刷新数据", for: .refreshing)
            flatHeader?.lastUpdatedTimeLabelText = { date in
                
                guard let _date = date else { return "暂无刷新时间" }
                
                let formmater = DateFormatter()
                formmater.dateFormat = "yyyy-MM-dd"
                return String(format: "刷新时间: %@", formmater.string(from: _date))
                
            }
            tableView.refreshHeader = flatHeader
        }
      
        //是否一进入页面就刷新
        if self.refreshEndController(){
            
            self.tableView.refreshHeader?.beginRefreshing()
        }
        //加载更多
        if self.refreshLoadMore(){
            
            flatBackFooter = ZVRefreshBackFlatFooter(target: self, action: #selector(refreshFooterHandler(_:)))
            flatBackFooter?.setTitle("上拉加载更多数据", for: .idle)
            flatBackFooter?.setTitle("释放开始加载数据", for: .pulling)
            flatBackFooter?.setTitle("正在刷新数据", for: .refreshing)
            flatBackFooter?.setTitle("没有更多数据", for: .noMoreData)
            tableView.refreshFooter = flatBackFooter
        }
        
        
        
        
        
    }
    @objc func refreshFooterHandler(_ refreshFooter: ZVRefreshFooter?) {
        
        
      
    }
    
    @objc func refreshHeaderHandler(_ refreshFooter: ZVRefreshFooter?) {
        
     
    }
    
    

}

extension BaseTableViewController{
    
    
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
        
        var objectModel:Any?=nil
        if indexPath.row<self.dataArray.count {
            
            objectModel=self.dataArray[indexPath.row]
        }
        
        let cell=self.layoutCellWithData(object: objectModel!, atIndexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var objectModel:Any?=nil
        if indexPath.row<self.dataArray.count {
            
            objectModel=self.dataArray[indexPath.row]
        }
        let rowHeight=self.tableViewCellHeightForData(object: objectModel!, atIndexPath: indexPath)
        return rowHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var objectModel:Any?=nil
        if indexPath.row<self.dataArray.count {
            
            objectModel=self.dataArray[indexPath.row]
        }
        self.clickedCell(object: objectModel!, atIndexPath: indexPath)
    }
}
