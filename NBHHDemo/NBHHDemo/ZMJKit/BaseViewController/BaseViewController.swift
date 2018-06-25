//
//  BaseViewController.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/21.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    let statusbarHeight = UIApplication.shared.statusBarFrame.height //获取statusBar的高度
    var height:CGFloat?
    
    var _params=[String:Any]()
    var params:[String:Any]{
        
        set{
            _params=newValue
        }
        get{
            
            return _params
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        height=statusbarHeight+(self.navigationController?.navigationBar.frame.size.height)!
    }
    
    
}


extension BaseViewController{
    
    //push页面跳转
    func pushViewController(className:String) -> Void {
        
        pushViewController(className: className, withParams: [:])
    }
    
    func pushViewController(className:String,withParams params:[String:Any]) -> Void {
        
        
        self.view.endEditing(true)
        let newViewController=self.createViewControlelr(className: className)
        
        let newViewVC=newViewController as! BaseViewController
        
        newViewVC.params=params
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
            print("无法转换成UIViewController")
            return nil
        }
        
        // 3.通过Class创建对象
        let childController = clsType.init()
        childController.hidesBottomBarWhenPushed=true
        return childController
        
    }
    
    //present跳转
    func presentingViewController(className:String) -> Void {
        
        presentingViewController(className: className, params: [:])
    }
    
    func presentingViewController(className:String,params:[String:Any]) -> Void {
    
        self.view.endEditing(true)
        let newViewController=self.createViewControlelr(className: className)
        
        let newViewVC=newViewController as! BaseViewController
        
        newViewVC.params=params
        
        let navigationController=MLNavigationController(rootViewController: newViewController!)
        self.navigationController?.present(navigationController, animated: true)
    }
    
    func dismissPrestedViewController() -> Void {
        
        if (self.presentedViewController != nil) {
            
            self.presentedViewController?.dismiss(animated: true, completion: {
            
            })
        }
    }
    func dismissPrestingViewController() -> Void {
        
        if (self.presentingViewController != nil) {
            
            self.presentingViewController?.dismiss(animated: true, completion: {
                
            })
        }
    }
    
    
    
}
