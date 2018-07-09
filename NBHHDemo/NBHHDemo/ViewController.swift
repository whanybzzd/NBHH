//
//  ViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/21.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit
import SnapKit
import ReactiveSwift
import HandyJSON
import SwiftyJSON
import KRProgressHUD
class ViewController: BaseViewController {
    let loginView=LoginView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSubView()
        racInitSubView()
    }
    
    
    //UI
    func initSubView() {
        
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { (make) in
            
            make.edges.equalTo(view).inset(UIEdgeInsetsMake(0, 0, 0, 0))
        }
        
        
    }
    
    //登录逻辑处理
    func racInitSubView() {
        
        
        //label点击事件
        let registerTapClick=UITapGestureRecognizer.init()
        registerTapClick.reactive.stateChanged.observeValues {[unowned self] (tap) in
            
            self.pushViewController(className: "TestViewController", withParams: ["title":"首页"])
        }
        self.loginView.registerlabel.addGestureRecognizer(registerTapClick)
        
        
        
        
    }
  
}

