//
//  Model.swift
//  SBS
//
//  Created by ZMJ on 2018/6/18.
//  Copyright © 2018年 ZMJ. All rights reserved.
//
import HandyJSON
class Model: HandyJSON {
   
    var status: Int?
    var info: String=""
    var data:AnyObject?
    
   public required init() {
        
    }
    
}
class UserMessage:HandyJSON {
    
    var companyId:Int?
    var createTime:String=""
    var email:String=""
    var id:Int?
    var lastLoginTime:String=""
    var nickname:String=""
    var pswd:String=""
    var status:Int?
    public required init() {
        
    }
}

