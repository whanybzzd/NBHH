//
//  BaseRefreshViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/22.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit
import HandyJSON
class BaseRefreshViewController: BaseViewController {

    var dataArray:Array<Any>=Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

}

extension BaseRefreshViewController{
    
    //是否支持刷新
   @objc func refreshController() -> Bool {
        
        return false
    }
    
    //是否支持刷新更多
   @objc func refreshLoadMore() -> Bool {
        
        return false
    }
    //是否一进入页面就刷新
    @objc func refreshEndController() -> Bool {
        
        return false
    }
   @objc func layoutCellWithData(object:Any,atIndexPath:IndexPath) -> UITableViewCell {
        
        return UITableViewCell.init()
    }
    
    @objc  func clickedCell(object:Any,atIndexPath:IndexPath) -> Void {
        
        
    }
    
   @objc func cellCount() -> Int {
        
        return self.dataArray.count
    }
}
