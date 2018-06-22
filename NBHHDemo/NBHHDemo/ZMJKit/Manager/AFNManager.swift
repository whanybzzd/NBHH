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
import HandyJSON
private let ManagerWorkRequestShareInstance=AFNManager()
//属性设置
class AFNManager {

    class var sharedInstance:AFNManager {
        
        return ManagerWorkRequestShareInstance
    }
    
    
    
}

extension AFNManager{
    
    
    
    
    func requestResult(url:String,params:[String:Any],method:HTTPMethod)->SignalProducer<Any,NetworkError>{
        
        
        return SignalProducer<Any,NetworkError>{ observer, disposable in
            
            
            let firstSearch = SignalProducer<(), NetworkError>(value: ())
            let load = firstSearch.concat(SignalProducer.empty)
            load.on(value:{
                
                self.result(url: url, params:params,method: method)
                    .start({event in
                        
                        switch event{
                            
                        case.value(let value):
                            
                            observer.send(value: value)
                            observer.sendCompleted()
                            
                        case .failed(let error):
                            observer.send(error: error)
                            
                        case .completed:
                            break
                        case .interrupted:
                            observer.sendInterrupted()
                        }
                    })
            }).start()
        }
    }
    
    
    
    //result请求
   private func result(url:String,params:[String:Any],method:HTTPMethod)->SignalProducer<Any, NetworkError> {
        
        return SignalProducer {observer,disponsable in
            
            
            self.httpRequest(url: url, params: params, method: method, success: { (responseObject) in

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
                let jsonModel=JSONDeserializer<Model>.deserializeFrom(json: json.description)
                if 1==jsonModel?.status{
                    
                    success(jsonModel?.data as AnyObject)
                }else{
                    failure(((jsonModel?.info)!,Error.self as! Error))
                }
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



