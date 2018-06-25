//
//  TestOneHeadView.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/25.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class TestOneHeadView: UIView,SDCycleScrollViewDelegate {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor=UIColor.red
        
        self.addSubview(self.sdScrollView)
        
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var sdScrollView:SDCycleScrollView = {()->SDCycleScrollView in
        
        let SdScrollView=SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: self.width, height: self.height), delegate: self, placeholderImage: UIImage.init(named: ""))
        SdScrollView?.currentPageDotColor=UIColor.red
        SdScrollView?.pageControlAliment=SDCycleScrollViewPageContolAlimentCenter
        return SdScrollView!
    }()
    
    func cycleScrollView(_ cycleScrollView: SDCycleScrollView!, didSelectItemAt index: Int) {
        
        print("点击:\(cycleScrollView.imageURLStringsGroup[index])")
        let baseVC=UIView.currentViewController() as! BaseViewController
        baseVC.pushViewController(className: "TestViewController", withParams: ["title":"我日"])
    }
}
