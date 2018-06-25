//
//  Manager.swift
//  SBS
//
//  Created by ZMJ on 2018/6/19.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

import UIKit

//配置文件
let NBHHBACK_ITEM_NAME = "button_arrow_left"//统一返回按钮
let SCREEN_WIDTH = UIScreen.main.bounds.size.width//宽度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height//高度
let kCachedUserModel = "kCachedUserModel"//缓存数据的key
//按照比例来适配
let KSCREEN_WIDTH = SCREEN_WIDTH/375.0
let KSCREEN_HEIGHT = SCREEN_HEIGHT/667.0



//总的请求地址
let HTTPAPI_HOST_NAME = "http://211.149.244.248:8032/"


let HTTPAPI_LOGIN_NAME = "user/login" //登录Api
let HTTPAPI_CUSTOMER_NAME = "customer/list"//获取客户列表
