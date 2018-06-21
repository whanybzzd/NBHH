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
        
        self.loginView.buttonClick.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            
            KRProgressHUD.show()
            LoginViewModel.sharedInstance.loginResult(username: "lw", password: "666666", nextPageTrigger: SignalProducer.empty)
                .on(value: { response in
                    
                    //只能在这个地方转换TODO:请求层转换的时候回报错，估计是swift机制不允许
                    let json=JSON(response)
                    let jsonModel=JSONDeserializer<UserMessage>.deserializeFrom(json: json.description,designatedPath:"data")
                    print("res:\(String(describing: jsonModel!.nickname))")
                    KRProgressHUD.dismiss()
                    print("")
                })
                .on(failed:{error in
                    
                    print("错误:\(error)")
                    KRProgressHUD.showError()
                })
                .start()
        }
        
    }
}

