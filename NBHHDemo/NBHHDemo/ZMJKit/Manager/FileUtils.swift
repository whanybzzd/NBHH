//
//  FileUtils.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/28.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

private let sharedInstance=FileUtils()
//属性设置
class FileUtils {
    
    class var sharedInstance:FileUtils {
        
        return self.sharedInstance
    }
    
}

extension FileUtils{
    
    //MARK:APP打包文件运行的目录
    func DirectoryPathOfBundle() -> String {
        
        return Bundle.main.resourcePath!
    }
    
    //MARK:常用沙盒里的目录
    func DirectoryPathOfHome() -> String {
        
        return NSHomeDirectory()
    }
    
    //MARK:通常存放应用中建立的文件，如数据库文件，或程序中浏览到的文件数据
            //itunes备份该目录
    
    func DirectoryPathOfDocuments() -> String {
        
        
        let paths=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        return paths as String
    }
    
    //MARK:itunes备份该目录除了Caches
    func DirectoryPathOfLibrary() -> String {
        
        let paths=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        return paths as String
    }
    
    //MARk:通常保存页面缓存数据 退出app不被清除 itunes不备份该目录
    func DirectoryPathOfLibraryCaches() -> String {
        
        let paths=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        
        return paths as String
    }
    
    //保存NSUserDefaults（bounldId.plist）
    func DirectoryPathOfLibraryPreferences() -> String {
        

        let libraryPath=NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0] as NSString
        return libraryPath.appendingPathComponent("Preferences")
        
    }
    
    //MARK:通常保存临时数据，比如要上传的图片；下载的临时文件等 当内存吃紧时，被ios系统判断是否需要清空该目录
    func DirectoryPathOfTmp() -> String {
        
        return NSTemporaryDirectory()
    }
    
    private func ensureParentDirectory(filePath:String)->Void{

        let deleteinglast=filePath as NSString
        let directoryPath=deleteinglast.deletingLastPathComponent
        var isDirectory: ObjCBool = false
         let file=FileManager.default.fileExists(atPath: directoryPath, isDirectory: &isDirectory)
        if !file {
            
           try! FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    //MARK:判断文件或目录是否存在
    func isExistsAtPath(path:String) -> Bool {
    
        return FileManager.default.fileExists(atPath:path)
    }
    
    //MARK:确保filepath目录存在，不存在就创建一个
    func ensureDirectory(directoryPath:String) -> Void {
        var isDirectory: ObjCBool = false
      let file=FileManager.default.fileExists(atPath: directoryPath, isDirectory: &isDirectory)
        if !file{
            
            self.ensureParentDirectory(filePath: directoryPath)
           try! FileManager.default.createDirectory(atPath: directoryPath, withIntermediateDirectories: true, attributes: nil)
        }
        //return directoryPath
    }
    
    
    
    
    //MARK:文件拷贝  只能拷贝文件，不能拷贝目录！
    func copyFileFromPath(sourceFilePath:String,toPath targetFilePath:String) -> Bool {
        
        var isSucces = false
        let file=FileManager.default.fileExists(atPath: sourceFilePath)
        if !file {
            
            return false
        }
        
        let file1=FileManager.default.fileExists(atPath: targetFilePath)
        if file1 {
            
            isSucces=deleteFileOrDirectory(deletePath: targetFilePath)
        }

       try! FileManager.default.copyItem(atPath: sourceFilePath, toPath: targetFilePath)
        return isSucces
    }
    
    //MARK:删除文件和文件夹 如果是目录就删除整个目录包括其下的文件和文件夹；如果是文件就直接删除文件
    func deleteFileOrDirectory(deletePath:String) -> Bool {
        
        let isSuccess=true
        let file=FileManager.default.fileExists(atPath: deletePath)
        if !file {
            
            return false
        }
       try! FileManager.default.removeItem(atPath: deletePath)
        return isSuccess
    }
    
    
    //MARK:获取目录下所有文件和目录的路径
    func allPathsInDirectoryPath(directoryPath:String) -> [ String] {
        
        return try! FileManager.default.contentsOfDirectory(atPath: directoryPath)
    }
    
    //MARK:获取目录下所有文件的属性（filename + filesize）
    
    
    func attributesOfAllFilesInDirectoryPath(directoryPath:String) -> [Any] {
        
        let filesName=try! FileManager.default.contentsOfDirectory(atPath: directoryPath)
        var fileAttributes=[Any]()
       
        for fileName in filesName {
            let names=directoryPath as NSString
           let filePath=names.appendingPathComponent(fileName)
             var isDir: ObjCBool = false
          let isExists=FileManager.default.fileExists(atPath: filePath, isDirectory: &isDir)
            if fileName.lowercased().hasSuffix("ds_store") && isExists{
                
                let attributes=try! FileManager.default.attributesOfItem(atPath: filePath)
                
                let fileSize=String(format: "\(attributes.count)")
                fileAttributes.append(["filename":fileName,"filesize":fileSize])
            }
        
        }
        return fileAttributes
    }
    //MARK:清空目录下所有文件和目录，但保持当前目录的存在
    func clearDirectoryPath(directoryPath:String) -> Void {
        
        if deleteFileOrDirectory(deletePath: directoryPath) {
            
            ensureDirectory(directoryPath: directoryPath)
        }
    }
}
