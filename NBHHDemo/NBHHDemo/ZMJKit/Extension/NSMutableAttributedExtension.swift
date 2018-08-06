//
//  NSMutableAttributedExtension.swift
//  NBHHDemo
//
//  Created by jktz on 2018/8/6.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class NSMutableAttributedExtension: NSMutableAttributedString {

    
    /// 改变文字大小和颜色
    ///
    /// - Parameters:
    ///   - changeStr: 改变的文字
    ///   - changeColor: 改变文字的颜色
    ///   - changeFont: 改变文字的大小
    ///   - wholeStr: 总的文字
    ///   - wholeColor: 总的文字颜色
    ///   - wholeFont: 总的文字大小
    /// - Returns: 修改后的字符串
    func changeValueStr(changeStr:String,changeColor:UIColor,changeFont:UIFont,wholeStr:String,wholeColor:UIColor,wholeFont:UIFont) -> NSMutableAttributedString {
        
        let mutableAttributed=NSMutableAttributedString.init(string: wholeStr)
        
        let attributedKey=[NSAttributedStringKey.foregroundColor: wholeColor,
                           NSAttributedStringKey.font: wholeFont] as [NSAttributedStringKey : Any]
        
        mutableAttributed.addAttributes(attributedKey, range: NSRange.init(location: 0, length: wholeStr.count))
        
        
        let attributedKeys=[NSAttributedStringKey.foregroundColor: changeColor,
                           NSAttributedStringKey.font: changeFont] as [NSAttributedStringKey : Any]
        mutableAttributed.addAttributes(attributedKeys, range: NSRange.init(location: 0, length: changeStr.count))
        
        return mutableAttributed
    }
}



