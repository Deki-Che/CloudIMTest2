//
//  ConversationViewController.swift
//  CloudIMTest2
//
//  Created by Deki on 15/10/9.
//  Copyright © 2015年 Deki. All rights reserved.
//

import UIKit

class ConversationViewController: RCConversationViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.targetId = "xiaoche2"
//        self.userName = "小车2"
//
//        
//        self.conversationType = .ConversationType_PRIVATE
//        self.title = "与 " + self.userName + " 私聊中"
        
        self.setMessageAvatarStyle( RCUserAvatarStyle.USER_AVATAR_CYCLE)
        
        
        }
        
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //隐藏tabBar
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = true
    }
    
    // 显示tabBar
    override func viewWillDisappear(animated: Bool) {
        self.tabBarController?.tabBar.hidden = false
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        
//        self.tabBarController?.tabBar.hidden = false    
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    


