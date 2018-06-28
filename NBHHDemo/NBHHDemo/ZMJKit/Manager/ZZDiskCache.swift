//
//  ZZDiskCache.swift
//  SBS
//
//  Created by ZMJ on 2018/6/19.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

import UIKit

private let page = ZZDiskCache(type:.Object)
private let image = ZZDiskCache(type:.Image)
private let voice = ZZDiskCache(type:.Voice)

//会在cache下创建目录管理
enum CacheFor:String{
    case Object = "zzObject"     //页面对象缓存 (缓存的对象)
    case Image = "zzImage"  //图片缓存 (缓存NSData)
    case Voice = "zzVoice"  //语音缓存 (缓存NSData)
}

open class ZZDiskCache {
    
    fileprivate let defaultCacheName = "zz_default"
    fileprivate let cachePrex = "com.zz.zzdisk.cache."
    fileprivate let ioQueueName = "com.zz.zzdisk.cache.ioQueue."
    
    fileprivate var fileManager: FileManager!
    fileprivate let ioQueue: DispatchQueue
    var diskCachePath:String
    // 针对Page
    open class var sharedCacheObj: ZZDiskCache {
        return page
    }
    
    // 针对Image
    open class var sharedCacheImage: ZZDiskCache {
        return image
    }
    
    // 针对Voice
    open class var sharedCacheVoice: ZZDiskCache {
        return voice
    }
    
    fileprivate var storeType:CacheFor
    
    init(type:CacheFor) {
        self.storeType = type
        let cacheName = cachePrex+type.rawValue
        ioQueue = DispatchQueue(label: ioQueueName+type.rawValue, attributes: [])
        //获取缓存目录
        let paths = NSSearchPathForDirectoriesInDomains(.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        
        diskCachePath = (paths.first! as NSString).appendingPathComponent(cacheName)
        
        ioQueue.sync { () -> Void in
            self.fileManager = FileManager()
            //先创建好对象的文件夹
            do {
                try self.fileManager.createDirectory(atPath: self.diskCachePath, withIntermediateDirectories: true, attributes: nil)
            } catch _ {}
        }
    }
    
    
    //MARK:删除文件夹
   open func delete(key:String) -> Void {
        
        try! FileManager.default.removeItem(atPath: self.cachePathForKey(key))
    }
    
    /**
     存储
     
     - parameter key:             键
     - parameter value:           值
     - parameter image:           图像
     - parameter data:            data
     - parameter completeHandler: 完成回调
     */
    open func stroe(_ key:String,value:Any? = nil,image:UIImage?,data:Data?,completeHandler:(()->())? = nil){
        
        
        
        /**
         对象存储 归档操作后写入文件
         
         - parameter key:   键
         - parameter value: 值
         - parameter path: 路径
         - parameter completeHandler: 完成后回调
         */
        func stroeObject(_ key:String,value:Any?,path:String,completeHandler:(()->())? = nil){
            ioQueue.async{
                let data = NSMutableData()
                var keyArchiver:NSKeyedArchiver!
                keyArchiver =  NSKeyedArchiver(forWritingWith: data)
                keyArchiver.encode(value, forKey: key.zz_MD5)  //对key进行MD5加密
                keyArchiver.finishEncoding() //归档完毕
                
                do {
                    try data.write(toFile: path, options: NSData.WritingOptions.atomic)  //存储
                    //完成回调
                    completeHandler?()
                }catch let err{
                    print("err:\(err)")
                }
            }
        }
        
        /**
         图像存储
         
         - parameter image:           image
         - parameter key:             键
         - parameter path:            路径
         - parameter completeHandler: 完成回调
         */
        func storeImage(_ image:UIImage,forKey key:String,path:String,completeHandler:(()->())? = nil){
            ioQueue.async {
                let data = UIImageJPEGRepresentation(image.zz_normalizedImage(), 0.9)
                if let data = data {
                    self.fileManager.createFile(atPath: path, contents: data, attributes: nil)
                }
            }
        }
        
        /**
         存储声音
         
         - parameter data:            data
         - parameter key:             键
         - parameter path:            路径
         - parameter completeHandler: 完成回调
         */
        func storeVoice(_ data:Data?,forKey key:String,path:String,completeHandler:(()->())? = nil){
            ioQueue.async {
                if let data = data {
                    self.fileManager.createFile(atPath: path+".ima4", contents: data, attributes: nil)
                }
            }
        }
        
        
        let path = self.cachePathForKey(key)
        switch storeType{
        case .Object:
            print("path:\(path)")
            stroeObject(key, value: value,path:path,completeHandler:completeHandler)
        case .Image:
            if let image = image{
                storeImage(image, forKey: key, path: path, completeHandler: completeHandler)
            }
        case .Voice:
            storeVoice(data, forKey: key, path: path, completeHandler: completeHandler)
        }
    }
    
   
    
    /**
     获取数据的方法
     
     - parameter key:              键
     - parameter objectGetHandler: 对象完成回调
     - parameter imageGetHandler:  图像完成回调
     - parameter voiceGetHandler:  音频完成回调
     */
    open func retrieve(_ key:String,objectGetHandler:((_ obj:Any?)->())? = nil,imageGetHandler:((_ image:UIImage?)->())? = nil,voiceGetHandler:((_ data:Data?)->())?){
        
        func retrieveObject(_ key:String,path:String,objectGetHandler:((_ obj:Any?)->())?){
            //反归档 获取
            DispatchQueue.global().async { () -> Void in
                if self.fileManager.fileExists(atPath: path){
                    let mdata = NSMutableData(contentsOfFile:path)
                    let unArchiver = NSKeyedUnarchiver(forReadingWith: mdata! as Data)
                    let obj = unArchiver.decodeObject(forKey: key)
                    objectGetHandler?(obj)
                }else{
                    objectGetHandler?(nil)
                }
            }
        }
        
        func retrieveImage(_ path:String,imageGetHandler:((_ image:UIImage?)->())?){
            DispatchQueue.global().async { () -> Void in
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                    if let image = UIImage(data: data){
                        imageGetHandler?(image)
                    }
                }else{
                    imageGetHandler?(nil)
                }
            }
        }
        
        func retrieveVoice(_ path:String,voiceGetHandler:((_ data:Data?)->())?){
            DispatchQueue.global().async { () -> Void in
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)){
                    voiceGetHandler?(data)
                }else{
                    voiceGetHandler?(nil)
                }
                
            }
        }
        
        
        let path = self.cachePathForKey(key)
        switch storeType{
        case .Object:
            retrieveObject(key.zz_MD5, path: path, objectGetHandler: objectGetHandler)
        case .Image:
            retrieveImage(path,imageGetHandler:imageGetHandler)
        case .Voice:
            retrieveVoice(path, voiceGetHandler: voiceGetHandler)
        }
    }
    
}

extension ZZDiskCache{
    func cachePathForKey(_ key: String) -> String {
        var fileName:String = ""
        if self.storeType == CacheFor.Voice {
            fileName = cacheFileNameForKey(key)+".wav"     //对name进行MD5加密
        }else{
            fileName = cacheFileNameForKey(key)
        }
        
        return (diskCachePath as NSString).appendingPathComponent(fileName)
    }
    
    func cacheFileNameForKey(_ key: String) -> String {
        return key.zz_MD5
    }
}


extension UIImage {
    
    func zz_normalizedImage() -> UIImage {
        if imageOrientation == .up {
            return self
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        draw(in: CGRect(origin: CGPoint.zero, size: size))
        let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return normalizedImage!;
    }
}


