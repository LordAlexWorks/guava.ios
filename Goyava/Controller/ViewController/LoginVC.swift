//
//  LoginVC.swift
//  Guava
//
//  Created by Susim Samanta on 02/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate {
    
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
    }
    //MARK: Button Action
    @IBAction func signUpButtonTapped(sender: UIButton) {
        let signupVc = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpVC") as! SignUpVC
        signupVc.modalTransitionStyle = .FlipHorizontal
        self.presentViewController(signupVc, animated: true) { () -> Void in
        }
    }
    @IBAction func loginButtonTapped(sender: UIButton) {
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            goToMain()
        #else
            goToScannerView()
        #endif
    }
    //MARK: Login navigation
    func goToScannerView(){
        let qrscannerVc = self.storyboard?.instantiateViewControllerWithIdentifier("QRScannerVC") as! QRScannerVC
        self.presentViewController(qrscannerVc, animated: true) { () -> Void in
        }
    }
    func goToMain(){
        let mainVc = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! MainVC
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainVc
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
