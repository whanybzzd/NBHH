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
            AFNManager.sharedInstance.requestResult(url:HTTPAPI_LOGIN_NAME,params:["username":"lw","password":"666666"],method: .post)
                .on(value: { response in
                    
                    let json=JSON(response)
                    let jsonModel=JSONDeserializer<UserMessage>.deserializeFrom(json: json.description)
                    
                    KRProgressHUD.dismiss({
                        
                        (UIApplication.shared.delegate as! AppDelegate) .setUpTabbarController()
                    })
                    
                })
                .on(failed:{error in
                    
                    print("错误:\(error)")
                    KRProgressHUD.showError()
                })
                .start()
        }
        
        //label点击事件
        let registerTapClick=UITapGestureRecognizer.init()
        registerTapClick.reactive.stateChanged.observeValues {[weak self] (tap) in
            
            self?.pushViewController(className: "TestViewController", withParams: ["title":"首页"])
        }
        self.loginView.registerlabel.addGestureRecognizer(registerTapClick)
        
        
        
        
    }
  
}

