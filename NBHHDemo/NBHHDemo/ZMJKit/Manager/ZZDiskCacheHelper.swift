//
//  ZZDiskCacheHelper.swift
//  SBS
//
//  Created by ZMJ on 2018/6/19.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

import UIKit

typealias `$` = ZZDiskCacheHelper

public struct ZZDiskCacheHelper {
    
    static func deleteObj(key:String){
        
        ZZDiskCache.sharedCacheObj.delete(key: key)
    }
    
    /**
      本地缓存对象
     */
    static func saveObj(_ key:String,value:Any?,completeHandler:(()->())? = nil){
    
        ZZDiskCache.sharedCacheObj.stroe(key, value: value, image: nil, data: nil, completeHandler: completeHandler)
        
    }
    
    /**
      本地缓存图片
     */
    static func saveImg(_ key:String,image:UIImage?,completeHandler:(()->())? = nil){
        
        ZZDiskCache.sharedCacheImage.stroe(key, value: nil, image: image, data: nil, completeHandler: completeHandler)
        
    }
    
    /**
     本地缓存音频 或者其他 NSData类型
     */
    static func saveVoc(_ key:String,data:Data?,completeHandler:(()->())? = nil){
    
        ZZDiskCache.sharedCacheVoice.stroe(key, value: nil, image: nil, data: data, completeHandler: completeHandler)
        
    }
    
    /**
      获得本地缓存的对象
     */
    static func getObj(_ key:String,compelete:@escaping ((_ obj:Any?)->())){
        
        ZZDiskCache.sharedCacheObj.retrieve(key, objectGetHandler: compelete, imageGetHandler: nil, voiceGetHandler: nil)
        
    }
    
    /**
     获得本地缓存的图像
     */
    static func getImg(_ key:String,compelete:@escaping ((_ image:UIImage?)->())){
        
        ZZDiskCache.sharedCacheImage.retrieve(key, objectGetHandler: nil, imageGetHandler: compelete, voiceGetHandler: nil)
        
    }
    
    /**
     获得本地缓存的音频数据文件
     */
    static func getVoc(_ key:String,compelete:@escaping ((_ data:Data?)->())){
        
        ZZDiskCache.sharedCacheVoice.retrieve(key, objectGetHandler: nil, imageGetHandler: nil, voiceGetHandler: compelete)
        
    }

}
