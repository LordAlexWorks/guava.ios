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
       Keyboard.showHide(self)
        emailTextField.attributedPlaceholder = NSAttributedString(string: "EMAIL", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "PASSWORD", attributes: [NSForegroundColorAttributeName : UIColor.grayColor()])
    }
    //MARK: Button Actions
    @IBAction func loginButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createAccountButtonTapped(sender: UIButton) {
        if isPassedInFormValidation() {
            self.doSignup()
        }else {
            UtilityManager.showAlertMessage("Invaid Email or Password", onViewcontrolller: self)
        }
    }
    
    func onDismiss(handler :SignupCompletionHandler ) {
        self.signUpHandler = handler
    }
    //MARK: Text Field Validation
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
    //MARK: Signup controller activity
    func doSignup(){
        let session = Session()
        session.email = self.emailTextField.text!
        session.password = self.passwordTextField.text!
        Loader.sharedInstance.showLoader()
        AuthenticationController.doSignup(session) { (obj, error) in
            dispatch_async(dispatch_get_main_queue(),{
                Loader.sharedInstance.hideLoader()
                if error != nil {
                    UtilityManager.showErrorAlertMessage("Network Error", onViewcontrolller: self)
                }else {
                    let session = obj as! Session
                    if (session.isSuccess == true) {
                        UtilityManager.showAlertMessage("Registration Success!", onViewcontrolller: self)
                        self.dismissViewControllerAnimated(false, completion: { 
                            self.goToMain()
                        })
                    }else {
                        if session.errorDescription != nil {
                            UtilityManager.showErrorAlertMessage(session.errorDescription!, onViewcontrolller: self)
                        }
                    }
                }
            })
        }
    }
    func navigateOnSignupSuccess() {
        self.dismissViewControllerAnimated(false) { () -> Void in
            if self.signUpHandler != nil {
                self.signUpHandler!()
            }
        }
    }
    //MARK: Background Tap
    func addBackgroundTapGesture(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
    }

    //GO TO MAIN
    
    func goToMain(){
        let myCardsVc = self.storyboard?.instantiateViewControllerWithIdentifier("MyCardsVC") as! MyCardsVC
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = myCardsVc
    }
}
