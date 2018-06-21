//
//  ExtensionString.swift
//  WWSwift_Test
//
//  Created by admin  on 2018/4/13.
//  Copyright © 2018年 吴伟. All rights reserved.
//

import UIKit


extension String {
    // LEFT
    // Returns the specified number of chars from the left of the string
    // let str = "Hello"
    // print(str.left(3))         // Hel
    func left(_ to: Int) -> String {
        return "\(self[..<self.index(startIndex, offsetBy: to)])"
    }
    
    // RIGHT
    // Returns the specified number of chars from the right of the string
    // let str = "Hello"
    // print(str.left(3))         // llo
    func right(_ from: Int) -> String {
        return "\(self[self.index(startIndex, offsetBy: self.count-from)...])"
    }
    
    // MID
    // Returns the specified number of chars from the startpoint of the string
    // let str = "Hello"
    // print(str.left(2,amount: 2))         // ll
    func mid(_ from: Int, amount: Int) -> String {
        let x = "\(self[self.index(startIndex, offsetBy: from)...])"
        return x.left(amount)
    }
    
    /// 截取第一个到第任意位置
    ///
    /// - Parameter end: 结束的位值
    /// - Returns: 截取后的字符串
    func stringCut(end: Int) ->String{
        print(self.count)
        if !(end < count) { return "截取超出范围" }
        let sInde = index(startIndex, offsetBy: end)
        return substring(to: sInde)
    }
    
    /// 截取人任意位置到结束
    ///
    /// - Parameter end:
    /// - Returns: 截取后的字符串
    func stringCutToEnd(star: Int) -> String {
        if !(star < count) { return "截取超出范围" }
        let sRang = index(startIndex, offsetBy: star)..<endIndex
        return substring(with: sRang)
    }
    
    /// 字符串任意位置插入
    ///
    /// - Parameters:
    ///   - content: 插入内容
    ///   - locat: 插入的位置
    /// - Returns: 添加后的字符串
    func stringInsert(content: String,locat: Int) -> String {
        if !(locat < count) { return "截取超出范围" }
        let str1 = stringCut(end: locat)
        let str2 = stringCutToEnd(star: locat)
        return str1 + content + str2
    }
    
    /// 计算字符串的尺寸
    ///
    /// - Parameters:
    ///   - text: 字符串
    ///   - rectSize: 容器的尺寸
    ///   - fontSize: 字体
    /// - Returns: 尺寸
    func  getStringSize(text: String, rectSize: CGSize,fontSize: CGFloat) -> CGSize {
        let str = text as NSString
        let rect = str.boundingRect(with: rectSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [kCTFontAttributeName as NSAttributedStringKey: UIFont.systemFont(ofSize: fontSize)], context: nil)
        
        return rect.size
    }
    
    
    
    
    /// 输入字符串 输出数组
    /// e.g  "qwert" -> ["q","w","e","r","t"]
    /// - Returns: ["q","w","e","r","t"]
    func stringToArr() -> [String] {
        let num = count
        if !(num > 0) { return [""] }
        var arr: [String] = []
        for i in 0..<num {
            let tempStr: String = self[self.index(self.startIndex, offsetBy: i)].description
            arr.append(tempStr)
        }
        return arr
    }
    
    /// 字符串截取         3  6
    /// e.g let aaa = "abcdefghijklmnopqrstuvwxyz"  -> "cdef"
    /// - Parameters:
    ///   - start: 开始位置 3
    ///   - end: 结束位置 6
    /// - Returns: 截取后的字符串 "cdef"
    func startToEnd(start: Int,end: Int) -> String {
        if !(end < count) || start > end { return "取值范围错误" }
        var tempStr: String = ""
        for i in start...end {
            let temp: String = self[self.index(self.startIndex, offsetBy: i - 1)].description
            tempStr += temp
        }
        return tempStr
    }
    
    /// 字符URL格式化
    ///
    /// - Returns: 格式化的 url
    func stringEncoding() -> String {
        let url = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return url!
    }
    
}
