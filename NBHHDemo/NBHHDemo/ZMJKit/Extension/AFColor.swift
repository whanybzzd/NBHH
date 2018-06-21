//
//  AFColor.swift
//  SBS
//
//  Created by jktz on 2018/6/20.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

import UIKit

extension UIColor {
    class func colorWithHexString(_ hex :String) -> UIColor {
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = String(cString.suffix(from:index))//cString.substring(from: index)
        }
        
        if (cString.count != 6) {
            return UIColor.red
        }
        
        //let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = cString.left(2)//cString.substring(to: rIndex)
        let otherString = cString.right(4)//cString.substring(from: rIndex)
        // let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString =  otherString.left(2) //otherString.substring(to: gIndex)
        //let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = otherString.right(2)//cString.substring(from: bIndex)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
        
    }
    
    
}

// MARK: 通过16进制初始化UIColor
public extension UIColor {
    
    public convenience init(numberColor: Int, alpha: CGFloat = 1.0) {
        self.init(hexColor: String(numberColor, radix: 16), alpha: alpha)
    }
    
    public convenience init(hexColor: String, alpha: CGFloat = 1.0) {
        var hex = hexColor.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        if hex.hasPrefix("0x") || hex.hasPrefix(("0X")) {
            hex.removeSubrange((hex.startIndex ..< hex.index(hex.startIndex, offsetBy: 2)))
        }
        
        guard let hexNum = Int(hex, radix: 16) else {
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
            return
        }
        
        switch hex.count {
        case 3:
            self.init(red: CGFloat(((hexNum & 0xF00) >> 8).duplicate4bits) / 255.0,
                      green: CGFloat(((hexNum & 0x0F0) >> 4).duplicate4bits) / 255.0,
                      blue: CGFloat((hexNum & 0x00F).duplicate4bits) / 255.0,
                      alpha: alpha)
        case 6:
            self.init(red: CGFloat((hexNum & 0xFF0000) >> 16) / 255.0,
                      green: CGFloat((hexNum & 0x00FF00) >> 8) / 255.0,
                      blue: CGFloat((hexNum & 0x0000FF) >> 0) / 255.0,
                      alpha: alpha)
        default:
            self.init(red: 0, green: 0, blue: 0, alpha: 0)
        }
    }
    
}

private extension Int {
    var duplicate4bits: Int {
        return self << 4 + self
    }
}
