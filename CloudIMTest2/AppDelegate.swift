//
//  AppDelegate.swift
//  CloudIMTest2
//
//  Created by Deki on 15/10/9.
//  Copyright © 2015年 Deki. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , RCIMUserInfoDataSource {

    var window: UIWindow?
  
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        // 获取用户信息，用户信息提供者
        
        
        let userInfo = RCUserInfo()
        userInfo.userId = userId
        
        switch userId {
        case "xiaoche" :
            userInfo.name = "小车"
            userInfo.portraitUri = "http://www.touxiang.cn/uploads/20131114/14-065802_226.jpg"
        case "xiaoche2" :
            userInfo.name = "小车2"
            userInfo.portraitUri = "http://b.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=38ecb37c54fbb2fb347e50167a7a0c92/d01373f082025aafc50dc5eafaedab64034f1ad7.jpg"

        default:
            print("无此用户")
        }
        
        return completion(userInfo)
    }
    
    func connectServe(completion: () -> Void) {
        //查询保存token
        _ = NSUserDefaults.standardUserDefaults().objectForKey("kDeviceToken") as? String
        
        // 初始化appkey
        RCIM.sharedRCIM().initWithAppKey("3argexb6rvude")
        
        // token测试链接
        // 小车2 token：Ef13XWP0j5hpihNweFZoswxnMSP7poeWkq+l04fkbqC7//f2SoavBWi59AA/e+QNcgNcvNxgCbo9sW7r+BV2FhJs/EDDEsLi
        // 小车 token： LG3c0oJHlU/42XshZ825P4IJmMcYhW94TveLC6HDDiay6gH5+VfRYkZ+LGldFI+cDltuWZjK5U+z0gCstNzDoxAUOGCuKJ9s
        
        RCIM.sharedRCIM().connectWithToken("Ef13XWP0j5hpihNweFZoswxnMSP7poeWkq+l04fkbqC7//f2SoavBWi59AA/e+QNcgNcvNxgCbo9sW7r+BV2FhJs/EDDEsLi", success: { (str: String!) -> Void in
            
            let currentUserInfo = RCUserInfo(userId: "xiaoche2", name: "小车2", portrait: nil)
            RCIMClient.sharedRCIMClient().currentUserInfo = currentUserInfo
            print("链接成功!")
            
            // 异步获取主线程，可以很快的显示 链接成功😄
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                completion()
            })
            
            }, error:{(_) -> Void in
                print("error")}) { () -> Void in
                    print("chucuole")
        }


    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

        
        // 设置用户信息提供者为自己appdelegate
        RCIM.sharedRCIM().userInfoDataSource = self
        
        // 获得新用户授权
        //如果使用美国站点，请加上这行代码 [AVOSCloud useAVCloudUS];
//        [AVOSCloud setApplicationId:@"MTSdMV9LsFWP7jxV1xkBVwyr"
//        clientKey:@"SC8HhC1QN24LfV6EPtChl7Qa"];
        AVOSCloud.setApplicationId("MTSdMV9LsFWP7jxV1xkBVwyr", clientKey: "SC8HhC1QN24LfV6EPtChl7Qa")
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

