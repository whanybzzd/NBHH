//
//  StorageManager.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/28.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit


private let sharedInstance=StorageManager()
//属性设置
class StorageManager {
    
   
    private var directoryPathOfHome:NSString=""
    private var directoryPathOfDocuments:NSString=""
    private var directoryPathOfLibrary:NSString=""
    private var directoryPathOfLibraryCaches:NSString=""
    private var directoryPathOfLibraryPreferences:NSString=""
    private var directoryPathOfTmp:NSString=""
    private var userDir="Common/"
    
    
    class var sharedInstance:StorageManager {
        
        return self.sharedInstance
    }
    
    
}

extension StorageManager{
    
    func initData() -> Void {
        
        directoryPathOfHome=FileUtils.sharedInstance.DirectoryPathOfHome() as NSString
        directoryPathOfDocuments=FileUtils.sharedInstance.DirectoryPathOfDocuments() as NSString
        directoryPathOfLibrary=FileUtils.sharedInstance.DirectoryPathOfLibrary() as NSString
        directoryPathOfLibraryCaches=FileUtils.sharedInstance.DirectoryPathOfLibraryCaches() as NSString
        directoryPathOfLibraryPreferences=FileUtils.sharedInstance.DirectoryPathOfLibraryPreferences() as NSString
        directoryPathOfTmp=FileUtils.sharedInstance.DirectoryPathOfTmp() as NSString
        
        ensureCommonDirectories()
    }
    
    
    //MARk:设置用户目录对应的id
    func setUserId(userId:String) -> Void {
        
        if !userId.isEmpty {
            
            let user=userId as NSString
            self.userDir=user.appending(user.hasSuffix("/") ? "" : "/")
        }else{
            
            self.userDir="Common/"
        }
        //确保用户缓存目录的存在
        ensureCommonDirectories()
    }
    
    //MARK:用户目录
    func directoryPathOfDocumentsByUserId() -> String {
        let doumentsByUserId=self.directoryPathOfDocuments as NSString
        return doumentsByUserId.appendingPathComponent(self.userDir)
    }
    
    //MARK:用户配置信息文件路径
    func filePathOfUserSettings() -> String {
        let UserSetting=directoryPathOfDocumentsByUserId() as NSString
        return UserSetting.appendingPathComponent("UserSettings.archive")
    }
    
    //MARK:公共根目录
    func directoryPathOfDocumentsCommon() -> String {
        
        return directoryPathOfDocuments.appendingPathComponent("Common/")
    }
    
    //MARK:公共配置信息文件路径
    func filePathOfCommonSettings() -> String {
        
        let seting=directoryPathOfDocumentsCommon() as NSString
        return seting.appendingPathComponent("CommonSettings.archive")
    }
    
    //MARK:公共日志文件目录
    func directoryPathOfDocumentsLog() -> String {
        
        return directoryPathOfDocuments.appendingPathComponent("Log/")
    }
    
    //MARK:用户的缓存目录
    func directoryPathOfLibraryCachesByUserId() -> String {
        
        return directoryPathOfLibraryCaches.appendingPathComponent(self.userDir)
    }
    
    //MARK:用户图片目录
    func directoryPathOfPicByUserId() -> String {
        let picById=directoryPathOfLibraryCachesByUserId() as NSString
        return picById.appendingPathComponent("Pics/")
    }
    
    //MARK:用户图片目录
    func directoryPathOfAudioByUserId() -> String {
        
        let audioById=directoryPathOfLibraryCachesByUserId() as NSString
        return audioById.appendingPathComponent("Audioes/")
    }
    
    //MARK:用户图片目录
    func directoryPathOfVideoByUserId() -> String {
        
        let VideoById=directoryPathOfLibraryCachesByUserId() as NSString
         return VideoById.appendingPathComponent("Videoes/")
    }
    
    //MARk:公共缓存目录
    func directoryPathOfLibraryCachesCommon() -> String {
        
        return directoryPathOfLibraryCaches.appendingPathComponent("Common/")
    }
    
    
    //MARK:设置config某个key对应的value
    func setConfigValue(value:Any,forkey:String) -> Void {
        
        setConfigWithValuesAndKeys(firstObject: value,forkey)
    }
    
    //MARK:设置config的通用方法
    func setConfigWithValuesAndKeys(firstObject:Any...) -> Void {
        
        let keys=[String]()
        let values=[String]()
        
        let args:va_list
        
        
        
        
        let valueCount=values.count
        if valueCount != keys.count {
            
            
        }else{
            
            var configDictionary:Dictionary<String,String>=[:]
            
            for index in 0..<valueCount{
                
                configDictionary["\(values[index])"] = "\(keys[index])"
            }
            
            let bs = archiveDictionary(dictionary: configDictionary, toFilePath: filePathOfCommonSettings(), overwrite: false)
            print("bs:\(bs)")
        }
        
    }
    
    
    //MARk:获取config中key对应的value
    func configValueForKey(key:String) -> Any {
        
        if key.isEmpty {
            
            return ""
        }
        
        let config=unarchiveDictionaryFromFilePath(filePath: filePathOfUserSettings())
        return config[key] ?? ""
    }

    
    //MARk:反序列化
    func unarchiveDictionaryFromFilePath(filePath:String) -> [String:String] {
        
        var dictionary=[String:String]()
        dictionary=NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [String : String]
    return dictionary
    
    }
    
    
    //MARK:序列化dict
    func archiveDictionary(dictionary:Any,toFilePath filePath:String) -> Bool {
        
        return archiveDictionary(dictionary: dictionary, toFilePath: filePath, overwrite: false)
    }
    
    //MARK:序列化通用方法
    func archiveDictionary(dictionary:Any,toFilePath filePath:String,overwrite:Bool) -> Bool {
        
        if overwrite {
            
            return NSKeyedArchiver.archiveRootObject(dictionary, toFile: filePath)
        }else{

            let allDictionary=[String:String]() as! NSMutableDictionary
            allDictionary.addEntries(from: unarchiveDictionaryFromFilePath(filePath: filePath))
            allDictionary .addEntries(from: dictionary as! [AnyHashable : Any])
            return NSKeyedArchiver.archiveRootObject(allDictionary, toFile: filePath)
        }
    }
    
    
    //MARK:删除整个目录/Library/Caches下所有的内容，并确保所有缓存目录都存在
    func clearLibraryCaches() -> Void {
        
        FileUtils.sharedInstance.clearDirectoryPath(directoryPath: self.directoryPathOfLibraryCaches as String)
        FileUtils.sharedInstance.clearDirectoryPath(directoryPath: self.directoryPathOfDocumentsLog() as String)
        
        ensureCommonDirectories()
        ensureUserDirectories()
    }
    
    
    //MARK:确保公共缓存目录的存在
    func ensureCommonDirectories() -> Void {
        
        FileUtils.sharedInstance.ensureDirectory(directoryPath: directoryPathOfDocumentsCommon())
        FileUtils.sharedInstance.ensureDirectory(directoryPath: directoryPathOfDocumentsLog())
        FileUtils.sharedInstance.ensureDirectory(directoryPath: directoryPathOfLibraryCachesCommon())
    }
    
    
    //MARK:确保用户缓存目录的存在
    func ensureUserDirectories() -> Void {
        
        FileUtils.sharedInstance.ensureDirectory(directoryPath: directoryPathOfDocumentsByUserId())
        FileUtils.sharedInstance.ensureDirectory(directoryPath: directoryPathOfLibraryCachesByUserId())
        FileUtils.sharedInstance.ensureDirectory(directoryPath: directoryPathOfAudioByUserId())
        FileUtils.sharedInstance.ensureDirectory(directoryPath: directoryPathOfVideoByUserId())
        FileUtils.sharedInstance.ensureDirectory(directoryPath: directoryPathOfPicByUserId())
    }
    
}
