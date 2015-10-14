//
//  RegTableViewController.swift
//  CloudIMTest2
//
//  Created by Deki on 15/10/12.
//  Copyright © 2015年 Deki. All rights reserved.
//

import UIKit

class RegTableViewController: UITableViewController {

    @IBOutlet var loginField: [UITextField]!
    
    var (userOk, passOk, mailOk) = (false, false, false)
    @IBOutlet weak var user: UITextBox!
    @IBOutlet weak var pass: UITextBox!
    @IBOutlet weak var mail: UITextBox!
    @IBOutlet weak var region: UITextBox!
    @IBOutlet weak var question: UITextBox!
    @IBOutlet weak var answer: UITextBox!
    
    
    func checkRequiredField() {
//        self.view.runBlockOnAllSubviews { (subview) -> Void in
//            if let subview = subview as? UITextField {
//                if subview.text!.isEmpty {
//                    print("文本框为🈳️")
//                }
//            }
//        }
        
        for textField in loginField {
            if textField.text!.isEmpty {
                self.errorNotice("必选项为🈳️！", autoClear: true)
//                print(" 必须选的项为🈳️")
            }
            
            
            // z 正则表达式和谓词匹配验证📮
            let regex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
            let predicte = NSPredicate(format: "SELF MATCHES %@", regex)
            guard predicte.evaluateWithObject(mail.text) else {
                self.errorNotice("Email出错", autoClear: true)
                return
            }
        }
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        self.title = "新用户注册"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneBarButtonItem" )
        
        self.navigationItem.rightBarButtonItem?.enabled = false
        
        let doneButton = self.navigationItem.rightBarButtonItem
        // 对用户名进行验证
        let v1 = AJWValidator(type: .String)
        v1.addValidationToEnsureMaximumLength(15, invalidMessage: "用户名字符最多15位")
        v1.addValidationToEnsureMinimumLength(4, invalidMessage: "用户名字符少于4个")
        self.user.ajw_attachValidator(v1)
        
        v1.validatorStateChangedHandler = {  (newState: AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                self.user.highlightState = UITextBoxHighlightState.Default
                self.userOk = true
            default :
                let erroMessge = v1.errorMessages.first as? String
                self.user.highlightState = UITextBoxHighlightState.Wrong(erroMessge!)
                self.userOk = false
            }
            doneButton?.enabled = self.userOk && self.passOk && self.mailOk
        }
        
        // 对密码进行验证
        let v2 = AJWValidator(type: .String)
        v2.addValidationToEnsureMaximumLength(15, invalidMessage: "密码字符最多15位")
        v2.addValidationToEnsureMinimumLength(4, invalidMessage: "密码 字符少于4个")
        self.pass.ajw_attachValidator(v2)
        v2.validatorStateChangedHandler = {  (newState: AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                self.pass.highlightState = UITextBoxHighlightState.Default
                self.passOk = true
            default :
                let erroMessge = v2.errorMessages.first as? String
                self.pass.highlightState = UITextBoxHighlightState.Wrong(erroMessge!)
                self.passOk = false
            }
            doneButton?.enabled = self.userOk && self.passOk && self.mailOk
        }
        
        let v3 = AJWValidator(type: AJWValidatorType.String)
        v3.addValidationToEnsureValidEmailWithInvalidMessage("Email格式错误！")
        self.mail.ajw_attachValidator(v3)
        v3.validatorStateChangedHandler = {
            (newState: AJWValidatorState) -> Void in
            switch newState {
            case .ValidationStateValid:
                self.mail.highlightState = UITextBoxHighlightState.Default
                self.mailOk = true
            default:
                let erroMessage = v3.errorMessages.first as? String
                self.mail.highlightState = UITextBoxHighlightState.Wrong(erroMessage!)
                self.mailOk = false
            }
            doneButton?.enabled = self.userOk && self.passOk && self.mailOk
        }

        
        
        
    }
    
    // 注册新用户
    func doneBarButtonItem() {
        // 显示等待
        self.pleaseWait()
         //    建立用户avobject
        let  User = AVObject(className: "XCUser")
        
        User["user"] = self.user.text
        User["pass"] = self.pass.text
        User["mail"] = self.mail.text
        User["region"] = self.region.text
        User["question"] = self.question.text
        User["answer"] = self.answer.text
        
        // 查询是否已经存在注册
        
        let query = AVQuery(className: "XCUser")
        query.whereKey("user", equalTo: self.user.text)
        
        // 执行查询
        
        query.getFirstObjectInBackgroundWithBlock { (object, error) -> Void in
            self.clearAllNotice()
            if object != nil {
                
                self.errorNotice("用户已经注册")
                self.user.becomeFirstResponder()
            } else {
                
                // 执行用户注册
                
                User.saveInBackgroundWithBlock({ (succeed, error) -> Void in
                    
                    if succeed {
                        self.successNotice("用户注册成功")
                        self.navigationController?.popViewControllerAnimated(true)
                    } else {
                        print(error)
                    }
                    
                })
                
            }
        }
        
        
        User.save()
        
        // 把输文本框的值输入到用户类
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
