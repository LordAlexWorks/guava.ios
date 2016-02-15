//
//  LoginVC.swift
//  Guava
//
//  Created by Susim Samanta on 02/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, SignInTableViewDelegate {

     var signDelegate: SignInTableViewDelegate?
    
    @IBOutlet weak var loginButtonPress: UIButton!
    @IBOutlet weak var facebookButtonPress: UIButton!
    @IBOutlet weak var twitterButtonPress: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.view.backgroundColor = UIColor.blackColor()
//        signDelegate = self
//        addBackgroundTapGesture()
        
        self.loginButtonPress.layer.cornerRadius = 27
        self.loginButtonPress.layer.borderWidth = 2
        self.loginButtonPress.layer.borderColor = UIColor.whiteColor().CGColor
        
        self.facebookButtonPress.layer.cornerRadius = 28
        self.facebookButtonPress.layer.borderColor = UIColor.facebookColor().CGColor
        self.facebookButtonPress.backgroundColor = UIColor.facebookColor()
        self.facebookButtonPress.layer.borderWidth = 2
        
        self.twitterButtonPress.layer.cornerRadius = 28
        self.twitterButtonPress.layer.borderColor = UIColor.twitterColor().CGColor
        self.twitterButtonPress.backgroundColor = UIColor.twitterColor()
        self.twitterButtonPress.layer.borderWidth = 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: SignInTableViewDelegate
    func signInButtonTapped(sender: UIButton) {
        performSegueWithIdentifier("signInToSingUpSegue", sender: nil)
    }

    //MARK: Login navigation
    @IBAction func loginButtonTapped(sender: UIButton) {                #if (arch(i386) || arch(x86_64)) && os(iOS)
            goToMyCard()
        #else
            goToScannerView()
        #endif
    }

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
//    func addBackgroundTapGesture(){
//        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
////        self.tableView.addGestureRecognizer(gestureRecognizer)
//    }
//    func handleTap(gestureRecognizer: UIGestureRecognizer) {
//        self.view.endEditing(true)
//    }
    
}
