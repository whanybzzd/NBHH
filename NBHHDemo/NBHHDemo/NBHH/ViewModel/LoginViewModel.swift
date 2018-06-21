//
//  LoginViewModel.swift
//  SBS
//
//  Created by jktz on 2018/6/20.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

import UIKit
import ReactiveSwift
import Result
import HandyJSON
private let requestModel=LoginViewModel()
class LoginViewModel{
    class var sharedInstance:LoginViewModel {
        
        return requestModel
    }
}

extension LoginViewModel{
    
    
    func loginResult(username:String,password:String,nextPageTrigger trigger: SignalProducer<(), NetworkError>)->SignalProducer<Any,NetworkError>{
        
        
        return SignalProducer<Any,NetworkError>{ observer, disposable in
            
            
            let firstSearch = SignalProducer<(), NetworkError>(value: ())
            let load = firstSearch.concat(trigger)
            load.on(value:{
                
                AFNManager.sharedInstance.post(url: HTTPAPI_LOGIN_NAME, params:["username":username,"password":password])
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
}
