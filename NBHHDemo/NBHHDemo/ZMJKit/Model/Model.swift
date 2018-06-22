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
    var data:Any!
    
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

class CustomerList:HandyJSON {
    
    var name:String=""
    var id:String=""
    var mobile:String=""
    var address:Int?
    var marriage_type:String=""
    var card_number:String=""
    var birthday:String=""
    var sex:String=""
    public required init() {
        
    }
}
