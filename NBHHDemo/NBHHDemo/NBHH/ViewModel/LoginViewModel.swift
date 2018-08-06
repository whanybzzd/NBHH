//
//  LoginViewModel.swift
//  NBHHDemo
//
//  Created by jktz on 2018/7/2.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit
import Result
import ReactiveSwift
import KRProgressHUD
import HandyJSON
import SwiftyJSON
protocol LoginViewModelProtocol{
    
    //判断总数据的方法
    func initSubViewData(accountInput:Signal<String?,NoError>,passwordInput:Signal<String?,NoError>)
    
    
    var account:MutableProperty<String>{get}
    var password:MutableProperty<String>{get}
    
    //接受账号和密码的错误信息
    var errorMessage:MutableProperty<String>{get}
    
    //账号、密码文本框的文字输入颜色
    var accountTextColor:MutableProperty<String>{get}
    var passwordTextColor:MutableProperty<String>{get}
    
    //登录方法
    var submitLoginAction:Action<Any?, Any?, NetworkError>{get}
}

extension LoginViewModel:LoginViewModelProtocol{}


class LoginViewModel {

    private(set) var account=MutableProperty("")
    private(set) var password=MutableProperty("")
    private(set) var errorMessage=MutableProperty("")
    private(set) var accountTextColor=MutableProperty("")
    private(set) var passwordTextColor=MutableProperty("")
    
    //用于接受账号密码输入错误的信息
    private var erors = (account:"账号不正确",password:"密码不正确")
    
    func initSubViewData(accountInput:Signal<String?,NoError>,passwordInput:Signal<String?,NoError>){
        
        account <~ accountInput.map({[unowned self] text in
            let acc=text
            self.accountTextColor.value=(acc?.count)!>5 ? "" : "账号长度不够"
            self.erors.account=(acc?.count)!>5 ? "" : "账号长度不够"
            return acc!
        })
        
        
        password <~ passwordInput.map({[unowned self] password in
            
            let pas=password?.substring(to: 16)
            let isValidPassword = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-zA-Z0-9].*)(?=.*[a-zA-Z\\W].*)(?=.*[0-9\\W].*).{6,16}$")
            self.passwordTextColor.value=isValidPassword.evaluate(with: pas) ? "" : "密码由6-16位数字和字母组成"
            self.erors.password=isValidPassword.evaluate(with: pas) ? "" : "密码由6-16位数字和字母组成"
            return pas!
        })
        
    }
    
    private(set) lazy var submitLoginAction:Action<Any?, Any?, NetworkError>=Action<Any?, Any?, NetworkError>(enabledIf:self.enableSubmit){[unowned self] _ -> SignalProducer<Any?, NetworkError> in
        
        return self.submitProducer
    }
    
    private var enableSubmit: Property<Bool> {
        return Property.combineLatest(account, password).map({ [unowned self] (acc, pass) -> Bool in
            
            if self.erors.account.count > 0 {
                
                self.errorMessage.value = self.erors.account
                
            } else if self.erors.password.count > 0 {
                
               self.errorMessage.value = self.erors.password
                
            }else {
                
                self.errorMessage.value = ""
                
            }
            
            return self.errorMessage.value.count == 0
        })
    }
    
    private var submitProducer:SignalProducer<Any?, NetworkError>{
        
        KRProgressHUD.show()
      return  AFNManager.sharedInstance.requestResult(url:HTTPAPI_LOGIN_NAME,params:["username":"lw","password":"666666"],method: .post)
            .on(value: { response in
                
                let json=JSON(response as Any)
                let jsonModel=JSONDeserializer<UserMessage>.deserializeFrom(json: json.description)
                print("jsonModel:\(jsonModel!)")
                
                UserDefaults.standard.set("1", forKey: kCachedUserModel)
                //此处要报错，不能这样用
                //`$`.saveObj(kCachedUserModel, value: jsonModel)//缓存用户信息
                
                //`$`.getObj("xx1x") { (obj) -> () in
                //            print("我日:\(obj)")
                //
                //            //         if let obj = obj as? Student{
                //            //            print("\(obj.id) , \(obj.name)")
                //            //         }
                //        }
                //
                //        `$`.deleteObj(key: "xxxx")//删除目录
                
                //        let homePath = NSHomeDirectory()
                //
                //        print("我曹::\(homePath)")
                
                KRProgressHUD.dismiss({
                    
                    (UIApplication.shared.delegate as! AppDelegate) .setUpTabbarController()
                })
                
            })
            .on(failed:{error in
                
                print("错误:\(error)")
                KRProgressHUD.showError()
            })
    }
    
}
