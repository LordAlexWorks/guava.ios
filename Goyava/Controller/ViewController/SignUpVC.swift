//
//  SignUpVC.swift
//  Guava
//
//  Created by Marko Budal on 05/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackgroundTapGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: Button Actions
    @IBAction func loginButtonTapped(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func createAccountButtonTapped(sender: UIButton) {
        goToScannerView()
    }
    //MARK: Login navigation
    func goToScannerView(){
        let qrscannerVc = self.storyboard?.instantiateViewControllerWithIdentifier("QRScannerVC") as! QRScannerVC
        self.presentViewController(qrscannerVc, animated: true) { () -> Void in
            
        }
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
