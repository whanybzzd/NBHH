//
//  AFNManager.swift
//  SBS
//
//  Created by ZMJ on 2018/6/18.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import ReactiveSwift
import Result
private let ManagerWorkRequestShareInstance=AFNManager()
//属性设置
class AFNManager {

    class var sharedInstance:AFNManager {
        
        return ManagerWorkRequestShareInstance
    }
    
    
    
}

extension AFNManager{
    
    //get请求
    func get(url:String,params:[String:Any])->SignalProducer<Any, NetworkError> {
        
        return SignalProducer {observer,disponsable in
            
            
            self.httpRequest(url: url, params: params, method: .get, success: { (responseObject) in
                
                observer.send(value: responseObject)
                observer.sendCompleted()
            }, failure: { (message,error) in
                
                observer.send(error: NetworkError(error: error as NSError))
            })
            
        }
    }
    
    
    //post请求
    func post(url:String,params:[String:Any])->SignalProducer<Any, NetworkError> {
        
        return SignalProducer {observer,disponsable in
            
            
            self.httpRequest(url: url, params: params, method: .post, success: { (responseObject) in

                observer.send(value: responseObject)
                observer.sendCompleted()
            }, failure: { (message,error) in
                
                observer.send(error: NetworkError(error: error as NSError))
            })
            
        }
    }
    
    

    
  private  func httpRequest(url:String,params:[String:Any],method:HTTPMethod,success:@escaping(_ response:AnyObject)->(),failure:@escaping(_ failure:(message:String,error:Error))->()) {
        
        let urlString=HTTPAPI_HOST_NAME+url
        Alamofire.request(urlString, method: method, parameters: params).responseJSON { (responseObject) in
            
            switch responseObject.result{
            case .success(let value):
                let json=JSON(value)
                success(json as AnyObject)
                
            case .failure(let error):
                failure(("请求错误",error))
            }
        
        }
    }
    
    //上传图片
   private func upload(url:String,params:[String:Any],data:[Data],name:[String],success:@escaping(_ response:[String:AnyObject])->(),failure:@escaping(_ failure:Error)->()) {
        
        let urlString=HTTPAPI_HOST_NAME+url
        Alamofire.upload(multipartFormData: { (multipartFormData) in
            
            let flag=params["flag"]
            let userId=params["userId"]
            multipartFormData.append(((flag as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: "flag")
            
            multipartFormData.append(((userId as AnyObject).data(using: String.Encoding.utf8.rawValue)!), withName: "userId")
            
            //多图上次
            for i in 0..<data.count{
                
                multipartFormData.append(data[i], withName: "files", fileName: name[i], mimeType: "image/png")
            }
        }, to: urlString) { (encodingResult) in
            
            switch encodingResult{
                
            case .success(let upload,_,_):
                upload.responseJSON(completionHandler: { (response) in
                    
                    if let value=response.result.value{
                        
                        success(value as! [String : AnyObject])
                    }
                })
            case .failure(let encodingError):
                failure(encodingError)
            }
        }
    }
    
    //上传视频
        
}



