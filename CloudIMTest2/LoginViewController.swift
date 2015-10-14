//
//  LoginViewController.swift
//  CloudIMTest2
//
//  Created by Deki on 15/10/12.
//  Copyright © 2015年 Deki. All rights reserved.
//

import UIKit


//    extension UIView {
//        // 状态栏属性
//        @IBInspectable var cornerRadius: CGFloat {
//            get {
//                return layer.cornerRadius
//            }
//            
//            set {
//                layer.cornerRadius = newValue
//                layer.masksToBounds = (newValue > 0)
//            }
//        }
//    }
//


class LoginViewController: UIViewController , RCAnimatedImagesViewDelegate{
    
    var (userOk, passOk) = (false, false)
    
    @IBOutlet weak var loginStackView: UIStackView!

    @IBOutlet weak var wallpaperImageView: RCAnimatedImagesView!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPass: UITextField!
    @IBAction func loginButton(sender: AnyObject) {
        if self.userName.text!.isEmpty {
            self.errorNotice("用户名为空")
        } else if self.userPass.text!.isEmpty {
            self.errorNotice("密码为空")
        } else {
            // 与云端信息进行匹配
            
            let query = AVQuery(className: "XCUser")
            query.whereKey("user", equalTo: self.userName.text)
            query.getFirstObjectInBackgroundWithBlock({ (object , error ) -> Void in
                if object == nil {
                    self.errorNotice("无此用户")
                } else {
                    //self.successNotice("此用户存在，请填写 密码")
                    // 判断密码是否正确
                    query.whereKey("pass", equalTo: self.userPass.text)
                    query.getFirstObjectInBackgroundWithBlock({ (succeed, erro) -> Void in
                        if succeed == nil {
                            self.errorNotice("密码不正确")
                        } else {
                            
                            self.performSegueWithIdentifier("toConversationList", sender: self)
                            //self.successNotice("密码正确")
                        }
                    })
                }
                
                
                
            })
            
            
            
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.wallpaperImageView.delegate = self
        self.wallpaperImageView.startAnimating()
        
        self.navigationController?.navigationBarHidden = true
        
        
        // 测试用户名和密码的输入
        
        
    }
    
    func animatedImagesNumberOfImages(animatedImagesView: RCAnimatedImagesView!) -> UInt {
        return 3
    }
    
    func animatedImagesView(animatedImagesView: RCAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
        return UIImage(named: "背景\(index + 1)")
    }
    
    
//    func animatedImagesNumberOfImages(animatedImagesView: JSAnimatedImagesView!) -> UInt {
//        return 3
//    }
//    
//    func animatedImagesView(animatedImagesView: JSAnimatedImagesView!, imageAtIndex index: UInt) -> UIImage! {
//        return UIImage(named: "背景\(index + 1)")
//    }
//    
//    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        UIView.animateWithDuration(1) { () -> Void in
        self.loginStackView.axis = UILayoutConstraintAxis.Vertical

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBarHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
