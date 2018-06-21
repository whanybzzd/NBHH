//
//  BaseViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/21.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var params:[String:Any]=[String:Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
}


extension BaseViewController{
    
    func pushViewController(className:String) -> Void {
        
        pushViewController(className: className, withParams: [:])
    }
    
    func pushViewController(className:String,withParams params:[String:Any]) -> Void {
        
        
        self.view.endEditing(true)
        let newViewController=self.createViewControlelr(className: className)

        let mutableDictionary=params
        if (newViewController?.isKind(of: BaseViewController.self))!{

            self.params=mutableDictionary
           
        }
        newViewController?.navigationItem.leftBarButtonItem=UIBarButtonItem.init(image: UIImage.init(named: NBHHBACK_ITEM_NAME), style: .plain, target: self, action: #selector(backItemClick))
        self.navigationController?.pushViewController(newViewController!, animated: true)
    }
    
    @objc func backItemClick() -> Void {
        
        self.navigationController?.popViewController(animated: true)
    }
    
   private func createViewControlelr(className:String)->UIViewController? {
    // 1.获取命名空间
    guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
        print("命名空间不存在")
        return nil
    }
    // 2.通过命名空间和类名转换成类
    let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + className)
    
    // swift 中通过Class创建一个对象,必须告诉系统Class的类型
    guard let clsType = cls as? UIViewController.Type else {
        print("无法转换成UITableViewController")
        return nil
    }
    
    // 3.通过Class创建对象
    let childController = clsType.init()
    childController.hidesBottomBarWhenPushed=true
    return childController
    
    }
    
}
