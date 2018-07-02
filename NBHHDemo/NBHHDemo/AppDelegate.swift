//
//  AppDelegate.swift
//  NBHHDemo
//
//  Created by jktz on 2018/6/21.
//  Copyright © 2018年 jktz. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window=UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor=UIColor.white
        self.window?.makeKeyAndVisible()
        
        
        if ((UserDefaults.standard.object(forKey: kCachedUserModel)) != nil) {
            setUpTabbarController()
        }else{
            setTabbarController()
        }
        return true
    }
    func setTabbarController() -> Void {
        
        let navc=MLNavigationController.init(rootViewController: ViewController.init())
         self.window?.rootViewController=navc
    }
    func setUpTabbarController() -> Void {
        
        self.window?.rootViewController=rootViewController()
    }

    func rootViewController() -> UIViewController {
        
        let tabClassArray=["TestOneViewController","TestTwoViewController"]
        let tabItemUnSeletedImageArray=["首页","更多"]
        let tabItemSeletedImageArray=["首页选中","更多选中"]
        let tabItemNamesArray=["首页","更多"]
        var viewControllers:Array<Any>=Array<Any>()
       
        for (index,item) in tabClassArray.enumerated(){
            
            let contentController=self.createViewControlelr(className: item)
            let tabbarItem=UITabBarItem.init(title: tabItemNamesArray[index],
                                             image: UIImage.init(named: tabItemUnSeletedImageArray[index])?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage.init(named: tabItemSeletedImageArray[index])?.withRenderingMode(.alwaysOriginal))
            
           //修改选中文字颜色
            tabbarItem.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.colorWithHexString("#f52735")], for: .selected)
            tabbarItem.imageInsets=UIEdgeInsetsMake(-1, 0, 1, 0)
            tabbarItem.titlePositionAdjustment=UIOffsetMake(0, -2)
            let navigationController=MLNavigationController(rootViewController: contentController!)
            navigationController.navigationController?.navigationBar.isTranslucent=true
            navigationController.tabBarItem=tabbarItem
            viewControllers.append(navigationController)
        }
        let tabBarController=BaseTabBarController()
        tabBarController.viewControllers=(viewControllers as! [UIViewController])
        //tabBarController.tabBar.backgroundImage=UIImage.init(named: "")
        return tabBarController
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
        return childController

    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }


}

