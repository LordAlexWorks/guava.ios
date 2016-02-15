//
//  SignUpVC.swift
//  Guava
//
//  Created by Marko Budal on 05/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController, SignInTableViewDelegate {

    var signDelegate: SignInTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signDelegate = self
        
        addBackgroundTapGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: SignInTableViewDelegate
    func signInButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //MARK: Login navigation
    @IBAction func loginButtonPress(sender: UIButton) {
        goToScannerView()
    }
    
    func goToScannerView(){
        let qrscannerVc = self.storyboard?.instantiateViewControllerWithIdentifier("QRScannerVC") as! QRScannerVC
        self.presentViewController(qrscannerVc, animated: true) { () -> Void in
            
        }
    }
    //MARK: Background Tap
    func addBackgroundTapGesture(){
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: "handleTap:")
//        self.tableView.addGestureRecognizer(gestureRecognizer)
    }
    func handleTap(gestureRecognizer: UIGestureRecognizer) {
        self.view.endEditing(true)
    }
    
}
