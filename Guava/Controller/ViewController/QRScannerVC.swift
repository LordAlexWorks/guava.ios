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
        self.qrScanner!.createQRScannerOnCompletion(self.scannerView, scannerHandler: { (obj, error) -> Void in
            if((obj) != nil) {
                let result = obj as! String
                print(result)
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                })
            }
            if((error) != nil) {
                print(error)
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                })
            }
        })
    }
    
    @IBAction func backButtonTapped(sender : UIButton) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
}
