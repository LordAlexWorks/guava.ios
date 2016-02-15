//
//  QRScannerVC.swift
//  Guava
//
//  Created by Susim Samanta on 06/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class QRScannerVC: UIViewController {
    var qrScanner : SSQRScanner?
    @IBOutlet weak var scannerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadQRCodeScanner()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func loadQRCodeScanner() {
        self.qrScanner = SSQRScanner()
        self.qrScanner!.createQRScannerOnCompletion(self.scannerView, scannerHandler: {[weak self] (obj, error) -> Void in
            if((obj) != nil) {
                let result = obj as! String
                print(result)
                if self != nil {
                    self!.dismissViewControllerAnimated(true, completion: { () -> Void in
                        let myCardsVc = self!.storyboard?.instantiateViewControllerWithIdentifier("MyCardsVC") as! MyCardsVC
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.window?.rootViewController = myCardsVc
                    })
                }
            }
            if((error) != nil) {
                print(error)
                if self != nil {
                    self!.dismissViewControllerAnimated(true, completion: { () -> Void in
                    })
                }
            }
        })
    }
    
    @IBAction func backButtonTapped(sender : UIButton) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
}