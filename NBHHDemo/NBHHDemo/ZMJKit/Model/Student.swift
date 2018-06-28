//
//  Student.swift
//  ZZDiskCache
//
//  Created by duzhe on 16/3/3.
//  Copyright © 2016年 dz. All rights reserved.
//

import Foundation

class Student: NSObject,NSCoding {
    
    var id:NSNumber?
    var name:String?
    
    override init() {
        
    }
    
    //MARK: -序列化
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.id, forKey: "id")
    }
    
    
    //MARK: -反序列化
    required init?(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "id") as? NSNumber
        self.name = aDecoder.decodeObject(forKey: "name") as? String
    }
}
