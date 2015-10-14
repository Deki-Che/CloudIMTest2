//
//  ConversationListViewController.swift
//  CloudIMTest2
//
//  Created by Deki on 15/10/10.
//  Copyright © 2015年 Deki. All rights reserved.
//

import UIKit

class ConversationListViewController: RCConversationListViewController {
    func ClickMenu1() {
        print("您点击了第一项！")
    }
    func ClickMenu2() {
        print("您点击了第2项！")
    }
    func ClickMenu3() {
                // 代码跳转到会话界面
                let conVC = ConversationViewController()
                conVC.targetId = "xiaoche2"
                conVC.userName = "小车2"
                conVC.conversationType = RCConversationType.ConversationType_PRIVATE
        
                conVC.title = conVC.userName
        
                self.navigationController?.pushViewController(conVC, animated: true)
        print("跳转到聊天界面！")
    }


    @IBAction func ShowMenu(sender: UIBarButtonItem) {
//kxMenu 做的pop
//        var frame = sender.valueForKey("view")?.frame
//        frame!.origin.y = frame!.origin.y + 30
//        KxMenu.showMenuInView(self.view, fromRect: frame! , menuItems:
//            [KxMenuItem(" 客服 " ,image: nil, target: self, action:"ClickMenu1"),
//            KxMenuItem(" 通讯录 " ,image: nil, target: self, action:"ClickMenu2") ,
//            KxMenuItem(" 测试代码跳转！ " ,image: nil, target: self, action:"ClickMenu3")
//            ]
//        )
        
        let items = [
        
            MenuItem(title: "客服", iconName:  "post_type_bubble_facebook", glowColor: UIColor.redColor(), index: 0),
        MenuItem(title: "小车", iconName: "post_type_bubble_youtube", glowColor: UIColor.blackColor(), index: 1),
        MenuItem(title: " 通讯录", iconName:  "post_type_bubble_twitter", glowColor: UIColor.brownColor(), index: 2),
        MenuItem(title: "关于", iconName: "post_type_bubble_googleplus", glowColor: UIColor.grayColor(), index: 3)
        ]
        
        let menu = PopMenu(frame: self.view.bounds, items: items)
        
        if menu != nil {
        menu.menuAnimationType = PopMenuAnimationType.NetEase
        
        }
        if menu.isShowed {
            return
        }
        
        
        menu.didSelectedItemCompletion = { ( selectedItem: MenuItem!) -> Void in
            
            print(selectedItem.index)
            
            switch selectedItem.index {
            case 1:
                self.ClickMenu3()
            default:
                print(selectedItem.index)
            }
            
        }
        
        menu.showMenuAtView(self.view)
        
    }
    
        
    let conVC = ConversationViewController()

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate
        appDelegate?.connectServe({ () -> Void in

            
            //  设置显示对话模式setDisplayConversationTypes 用rawValue 将其转化为整数，由于调用的是OC的东西
            self.setDisplayConversationTypes([
                RCConversationType.ConversationType_APPSERVICE.rawValue,
                RCConversationType.ConversationType_CHATROOM.rawValue,
                RCConversationType.ConversationType_CUSTOMERSERVICE.rawValue,
                RCConversationType.ConversationType_DISCUSSION.rawValue,
                RCConversationType.ConversationType_GROUP.rawValue,
                RCConversationType.ConversationType_PRIVATE.rawValue,
                RCConversationType.ConversationType_PUBLICSERVICE.rawValue,
                RCConversationType.ConversationType_SYSTEM.rawValue
                
                ])
            
            self.refreshConversationTableViewIfNeeded()
        })
    }
    
    override func onSelectedTableRow(conversationModelType: RCConversationModelType, conversationModel model: RCConversationModel!, atIndexPath indexPath: NSIndexPath!) {
        
//        // 代码跳转到会话界面
//        let conVC = ConversationViewController()
//        conVC.targetId = model.targetId
//        conVC.userName = model.conversationTitle
//        conVC.conversationType = RCConversationType.ConversationType_PRIVATE
//        
//        conVC.title = model.conversationTitle
//        
//        self.navigationController?.pushViewController(conVC, animated: true)
        
                conVC.targetId = model.targetId
                conVC.userName = model.conversationTitle
                conVC.conversationType = RCConversationType.ConversationType_PRIVATE
        
                conVC.title = model.conversationTitle
        self.performSegueWithIdentifier("tapOnCell", sender: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let destVC = segue.destinationViewController as? RCConversationViewController
        destVC?.targetId = self.conVC.targetId
        destVC?.userName = self.conVC.userName
        destVC?.conversationType = self.conVC.conversationType
        destVC?.title = self.conVC.title
    }

    

}
