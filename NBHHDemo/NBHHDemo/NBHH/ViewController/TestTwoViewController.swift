//
//  TestTwoViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/25.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class TestTwoViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title="更多"
        self.view.addSubview(twoView)
        initSubView()
    }
    
    func initSubView() -> Void {
        
        twoView.exitButton.reactive.controlEvents(.touchUpInside).observeValues { (button) in
            
            
            
            //点击事件
            let alertVC=UIAlertController.init(title: "提示", message: String(format: "张三向您发起了连麦的请求"), preferredStyle: .alert)
            
            let cancelAction=UIAlertAction.init(title: "拒绝", style: .cancel, handler: { (action) in
                
                UserDefaults.standard.removeObject(forKey: kCachedUserModel)
                (UIApplication.shared.delegate as! AppDelegate) .setTabbarController()
                
            })
            
            let okAction=UIAlertAction.init(title: "同意", style: .default, handler: { (action) in
                
            })
            alertVC.addAction(cancelAction)
            alertVC.addAction(okAction)
            self .present(alertVC, animated: true, completion: nil)
            
            var seconds=60
            Timer.bk_scheduledTimer(withTimeInterval: 1, block: { (timer) in
                
                seconds-=1
                okAction.setValue(String(format:"同意(\(seconds))"), forKey: "title")
                if seconds<=0{
                    timer?.invalidate()
                    okAction.setValue(String(format:"同意"), forKey: "title")
                    
                }
            }, repeats: true)
        }
        
        
    }
    
    
    lazy var twoView:TestTwoView={
        
        let view=TestTwoView(frame: CGRect(x: 0, y: height!, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-height!))
        view.backgroundColor=UIColor.blue
        return view
    }()
    
}
