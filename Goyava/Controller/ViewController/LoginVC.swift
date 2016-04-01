//
//  LoginVC.swift
//  Guava
//
//  Created by Susim Samanta on 02/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate {
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initilizeUITasks()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initilizeUITasks(){
        addBackgroundTapGesture()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        emailTextField.attributedPlaceholder = NSAttributedString(string: "EMAIL", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
    }
    //MARK: Button Action
    @IBAction func signUpButtonTapped(sender: UIButton) {
        let signupVc = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpVC") as! SignUpVC
        signupVc.modalTransitionStyle = .FlipHorizontal
        self.presentViewController(signupVc, animated: true) { () -> Void in
        }
        signupVc.onDismiss { [weak self]() -> Void in
            if self != nil {
                self?.goToScannerView()
            }
        }
    }
    @IBAction func loginButtonTapped(sender: UIButton) {
        self.callLoginController()
    }
    func callLoginController() {
        let login = Login()
        login.email = self.emailTextField.text!
        login.password = self.passwordTextField.text!
        AuthenticationController.doLogin(login) { (obj, error) in
            if error != nil {
                UtilityManager.showAlertMessage("Network Error", onViewcontrolller: self)
            }else {
                let login = obj as! Login
                if (login.isSuccess == true) {
                    dispatch_async(dispatch_get_main_queue(),{
                        self.pageOnLoginSuccess()
                    })
                }else {
                    UtilityManager.showAlertMessage("Login Error", onViewcontrolller: self)
                }
            }
        }
    }
    func pageOnLoginSuccess(){
        #if (arch(i386) || arch(x86_64)) && os(iOS)
            goToMain()
        #else
            goToScannerView()
        #endif
    }
    //MARK: Login navigation
    func goToScannerView(){
        let qrscannerVc = self.storyboard?.instantiateViewControllerWithIdentifier("QRScannerVC") as! QRScannerVC
        qrscannerVc.isAuthorizedForCamera { (isGranted) -> Void in
            if isGranted {
                    self.presentViewController(qrscannerVc, animated: true) { () -> Void in
                }
            }else {
                let alert = UIAlertController(title: "Alert", message: "Guava need your camera access. Settings->Guava->Camera.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                alert.addAction(UIAlertAction(title: "Settings", style: UIAlertActionStyle.Cancel, handler:{ action in
                    UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
                }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
    func goToMain(){
        let mainVc = self.storyboard?.instantiateViewControllerWithIdentifier("MainVC") as! MainVC
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainVc
    }
    
    //MARK: Background Tap
    func addBackgroundTapGesture(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
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
