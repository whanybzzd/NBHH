//
//  MJEnum.swift
//  NBHHDemo
//
//  Created by jktz on 2018/7/5.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit


public extension UIDevice {
    public func isX() -> Bool {
        if UIScreen.main.bounds.height == 812 {//表示是iphoneX
            return true
        }
        
        return false
    }
}
