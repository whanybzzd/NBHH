//
//  TestOneViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/25.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class TestOneViewController: BaseViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title="首页"
        viewControllerTest()
        self.view.addSubview(self.OneView)
        let bannerArray=["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1529922562783&di=53500c3f44a71dbfc1164552aafa67fe&imgtype=0&src=http%3A%2F%2Fimg5q.duitang.com%2Fuploads%2Fitem%2F201311%2F09%2F20131109141412_RXeTQ.thumb.700_0.jpeg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1529922562783&di=b8c5bfb002a495cc464eab8ff22e245a&imgtype=0&src=http%3A%2F%2Fimg5.duitang.com%2Fuploads%2Fitem%2F201311%2F09%2F20131109141427_vfjjr.thumb.700_0.jpeg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1529922562782&di=1b77a80406dbb6e7b104febb9f60a5ff&imgtype=0&src=http%3A%2F%2Fimg4.duitang.com%2Fuploads%2Fitem%2F201409%2F20%2F20140920232136_eF5et.jpeg"]
        
        self.OneView.bannerArray(banner: bannerArray)
    }
    
    lazy var OneView:TestOneView={()->TestOneView in
        
        let oneView=TestOneView(frame: CGRect(x: 0, y: height!, width: SCREEN_WIDTH, height: SCREEN_HEIGHT-height!))
        return oneView
    }()

}

extension TestOneViewController{
    
    
    func viewControllerTest() -> Void {
        
//        //通知
//        NotificationCenter.default.reactive.notifications(forName: Notification.Name(""), object: nil).observeValues { (values) in
//
//
//        }
//
//        NotificationCenter.default.post(name: NSNotification.Name(""), object: nil)
//
//
//        //kvo[weak self]=防止循环引用
//        self.view.reactive.producer(forKeyPath: "bounds").start{[weak self]rect in
//
//            print(self?.view ?? "")
//        }
//
//        //延迟加载
//        QueueScheduler.main.schedule(after: Date.init(timeIntervalSinceNow: 3)) {
//
//            //1.主线程调用
//        }
//        QueueScheduler.init().schedule(after: Date.init(timeIntervalSinceNow: 3)) {
//            //2.子线程调用
//        }
        
        let dict=["name":"张三","age":"18"]
        dict.forEach { (key,value) in
            
            print("key:\(key)==value:\(value)")
        }
        
    }
}
