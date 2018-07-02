//
//  TestTwoView.swift
//  NBHHDemo
//
//  Created by jktz on 2018/7/2.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class TestTwoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubView() -> Void {
        
        self.addSubview(exitButton)
        exitButton.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(50)
            make.top.equalTo(200)
        }
        
    }
    lazy var exitButton:UIButton={
        
        let button=UIButton()
        button.backgroundColor=UIColor.red
        button.setTitle("退出", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font=UIFont.systemFont(ofSize: 15)
        button.layer.cornerRadius=25
        return button
    }()
    
}
