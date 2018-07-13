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
    
    
    public func RatioW(x:CGFloat)->CGFloat{
        
        return CGFloat(x*(KSCREEN_WIDTH/375))//375是根据UI出图的比例
    }
    
    public func RatioH(x:CGFloat)->CGFloat{
        
        return CGFloat(x*(KSCREEN_WIDTH/667))//667是根据UI出图的比例
    }
    
}
