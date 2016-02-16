//
//  LoginVC.swift
//  Guava
//
//  Created by Susim Samanta on 02/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
            goToMyCard()
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
    func goToMyCard(){
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
    
}
