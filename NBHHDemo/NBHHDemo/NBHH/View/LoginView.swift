//
//  LoginView.swift
//  SBS
//
//  Created by jktz on 2018/6/20.
//  Copyright © 2018年 ZMJ. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class LoginView: UIView {

    lazy var userNameTextField:UITextField=UITextField()
    lazy var passwordTextField:UITextField=UITextField()
    lazy var buttonClick:UIButton=UIButton()
    lazy var registerlabel:UILabel=UILabel()
    
    
    override init(frame:CGRect){
        super.init(frame: frame)
        initSubView()
        racInitSubView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func racInitSubView() {
        
        viewModel=LoginViewModel()
        
        
    }
    
    var viewModel:LoginViewModelProtocol!{
        
        didSet{
            
            viewModel.initSubViewData(accountInput: self.userNameTextField.reactive.continuousTextValues, passwordInput: self.passwordTextField.reactive.continuousTextValues)
            
            userNameTextField.reactive.text <~ viewModel.account
            passwordTextField.reactive.text <~ viewModel.password
            
            //赋值文本框颜色
            userNameTextField.reactive.textColor <~ viewModel.accountTextColor.map({text in
                
                text.count == 0 ? UIColor.lightGray : UIColor.red
            })
            
            passwordTextField.reactive.textColor <~ viewModel.passwordTextColor.map({password in

                password.count == 0 ? UIColor.lightGray : UIColor.red
            })
            
            
            buttonClick.reactive.pressed = ButtonAction(viewModel.submitLoginAction)
            buttonClick.reactive.backgroundColor <~ viewModel.errorMessage.map({text in
                
                text.count == 0 ? UIColor.red : UIColor.lightGray
            })
        }
    }
    
    
    
    func initSubView() {
        
       self.addSubview(userNameTextField)
        userNameTextField.placeholder="请输入用户名"
        userNameTextField.textColor=UIColor.colorWithHexString("#333333")
        userNameTextField.tintColor=UIColor.colorWithHexString("#333333")
        userNameTextField.font=UIFont.systemFont(ofSize: 14)
        userNameTextField.layer.borderColor=UIColor.colorWithHexString("#333333").cgColor
        userNameTextField.layer.borderWidth=1
        userNameTextField.layer.cornerRadius=25
        userNameTextField.translatesAutoresizingMaskIntoConstraints=false
        userNameTextField.clearButtonMode=UITextFieldViewMode.always
        userNameTextField.leftViewMode=UITextFieldViewMode.always
        userNameTextField.autocorrectionType=UITextAutocorrectionType.no
        userNameTextField.autocapitalizationType=UITextAutocapitalizationType.none
        userNameTextField.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(50)
            make.top.equalTo(100)
        }
        
        
        self.addSubview(passwordTextField)
        passwordTextField.placeholder="请输入密码"
        passwordTextField.textColor=UIColor.colorWithHexString("#333333")
        passwordTextField.tintColor=UIColor.colorWithHexString("#333333")
        passwordTextField.font=UIFont.systemFont(ofSize: 14)
        passwordTextField.layer.borderColor=UIColor.colorWithHexString("#333333").cgColor
        passwordTextField.layer.borderWidth=1
        passwordTextField.layer.cornerRadius=25
        passwordTextField.translatesAutoresizingMaskIntoConstraints=false
        passwordTextField.clearButtonMode=UITextFieldViewMode.always
        passwordTextField.leftViewMode=UITextFieldViewMode.always
        passwordTextField.autocorrectionType=UITextAutocorrectionType.no
        passwordTextField.autocapitalizationType=UITextAutocapitalizationType.none
        passwordTextField.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(50)
            make.top.equalTo(userNameTextField.snp.bottom).offset(30)
        }
        
        self.addSubview(buttonClick)
        buttonClick .setTitle("登录", for: UIControlState.normal)
        //buttonClick.backgroundColor=UIColor.colorWithHexString("#d5d6db")
        //buttonClick.isEnabled=false
        buttonClick.backgroundColor=UIColor.lightGray
        buttonClick.setTitleColor(UIColor.white, for: UIControlState.normal)
        buttonClick.titleLabel?.font=UIFont.systemFont(ofSize: 15)
        buttonClick.layer.cornerRadius=25
        buttonClick.snp.makeConstraints { (make) in
            
            make.left.equalTo(15)
            make.right.equalTo(-15)
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
        }
        
        //注册label
        self.addSubview(registerlabel)
        registerlabel.text="注册"
        registerlabel.isUserInteractionEnabled=true
        registerlabel.font=UIFont.systemFont(ofSize: 15)
        registerlabel.textColor=UIColor.red
        registerlabel.snp.makeConstraints { (make) in
            
            make.centerX.equalTo(self)
            make.top.equalTo(buttonClick.snp.bottom).offset(20)
            make.height.equalTo(15)
        }
        
        
    }
}
