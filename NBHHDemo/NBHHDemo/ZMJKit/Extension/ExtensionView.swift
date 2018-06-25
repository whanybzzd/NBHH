//
//  ExtensionView.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/25.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

extension UIView{
    
    // MARK: - 常用位置属性
    public var left:CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            var frame = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    
    public var top:CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(newTop) {
            var frame = self.frame
            frame.origin.y = newTop
            self.frame = frame
        }
    }
    
    public var width:CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(newWidth) {
            var frame = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    
    public var height:CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(newHeight) {
            var frame = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    
    public var right:CGFloat {
        get {
            return self.left + self.width
        }
    }
    
    public var bottom:CGFloat {
        get {
            return self.top + self.height
        }
    }
    
    public var centerX:CGFloat {
        get {
            return self.center.x
        }
        
        set(newCenterX) {
            var center = self.center
            center.x = newCenterX
            self.center = center
        }
    }
    
    public var centerY:CGFloat {
        get {
            return self.center.y
        }
        
        set(newCenterY) {
            var center = self.center
            center.y = newCenterY
            self.center = center
        }
    }
    
    
    
    
    
    class func currentViewController(base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return currentViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            return currentViewController(base: tab.selectedViewController)
        }
        if let presented = base?.presentedViewController {
            return currentViewController(base: presented)
        }
        return base
    }
}

