//
//  SignUpVC.swift
//  Guava
//
//  Created by Marko Budal on 05/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

typealias SignupCompletionHandler = () -> Void

class SignUpVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
    var signUpHandler : SignupCompletionHandler?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilizeUITasks()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initilizeUITasks(){
        addBackgroundTapGesture()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil);
        emailTextField.attributedPlaceholder = NSAttributedString(string: "EMAIL", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
    }
    //MARK: Button Actions
    @IBAction func loginButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createAccountButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(false) { () -> Void in
            if self.signUpHandler != nil {
                self.signUpHandler!()
            }
        }
    }
    
    func onDismiss(handler :SignupCompletionHandler ) {
        self.signUpHandler = handler
    }
    //MARK: Background Tap
    func addBackgroundTapGesture(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    //MARK: Keyboard Show and Hide
    func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let viewFrame = self.view.frame
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.view.frame = CGRect(x: 0, y: -keyboardFrame.height+140, width: viewFrame.size.width, height: viewFrame.size.height)
        })
    }
    func keyboardWillHide(notification: NSNotification) {
        let viewFrame = self.view.frame
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.view.frame = CGRect(x: 0, y: 0, width: viewFrame.size.width, height: viewFrame.size.height)
        })
    }
}
