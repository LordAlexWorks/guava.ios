//
//  LoginVC.swift
//  Guava
//
//  Created by Susim Samanta on 02/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate {
    
    // Outlets
    @IBOutlet weak var emailTextField : UITextField!
    @IBOutlet weak var passwordTextField : UITextField!
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    //View method. Entry point of loading a view
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initilizeUITasks()
    }
    //memory warning method
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //This method for initializing some ui tasks e.g oberserver for key board notification and setting text filed ui tasks.
    func initilizeUITasks(){
        self.addBackgroundTapGesture()
        Keyboard.showHide(self)
        UtilityManager.addAttributedPlacehoder(self.emailTextField, passwordTextField: self.passwordTextField)
    }
    //MARK: Button Action
    @IBAction func signUpButtonTapped(sender: UIButton) {
        let signupVc = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpVC") as! SignUpVC
        signupVc.modalTransitionStyle = .FlipHorizontal
        self.presentViewController(signupVc, animated: true) { () -> Void in
        }
        signupVc.onDismiss { [weak self]() -> Void in
            if self != nil {
                self?.goToMain()
            }
        }
    }
    @IBAction func loginButtonTapped(sender: UIButton) {
        if isPassedInFormValidation() {
            guard appDelegate.isNetworkReachable else {
                return
            }
            self.handleLogin()
        }else {
            UtilityManager.showErrorAlertMessage("Invaid Email or Password", onViewcontrolller: self)
        }
    }
    
    //mthod will be responsible for passing text fileds validations
    func isPassedInFormValidation()-> Bool {
        if (self.emailTextField.text?.characters.count == 0) {
            return false
        }else if (self.passwordTextField.text?.characters.count == 0 ) {
            return false
        }else if (!UtilityManager.validateEmail(self.emailTextField.text!)){
            return false
        }
        return true
    }
    
    //Method will handle login service will fetch model data after succesful login
    func handleLogin() {
        let session = Session()
        session.email = self.emailTextField.text!
        session.password = self.passwordTextField.text!
        Loader.sharedInstance.showLoader()
        AuthenticationController.doLogin(session) { (obj, error) in
            dispatch_async(dispatch_get_main_queue(),{
                Loader.sharedInstance.hideLoader()
                if error != nil {
                    UtilityManager.showErrorAlertMessage("Network Error", onViewcontrolller: self)
                }else {
                    let session = obj as! Session
                    if (session.isSuccess == true) {
                        let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDel.user = AuthenticationController.getLocalUser()
                        self.goToMain()
                    }else {
                        UtilityManager.showErrorAlertMessage(session.errorDescription!, onViewcontrolller: self)
                    }
                }
            })
        }
    }
    
    //MARK: Login navigation
    func goToMain(){
        let myCardsVc = self.storyboard?.instantiateViewControllerWithIdentifier("MyCardsVC") as! MyCardsVC
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = myCardsVc
    }
    
}
