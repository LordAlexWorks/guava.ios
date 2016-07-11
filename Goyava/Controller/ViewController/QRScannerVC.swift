//
//  QRScannerVC.swift
//  Guava
//
//  Created by Susim Samanta on 06/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import AVFoundation

typealias CameraAccessHandler = (isGranted : Bool) -> Void

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
                print(result, terminator: "")
                if self != nil {
                    Loader.sharedInstance.showLoader()
                    ActivitiesController.addQRCodeActivity(result, handler: { (obj, error) in
                        DispatchQueue.main.async(execute: {
                            Loader.sharedInstance.hideLoader()
                            if error != nil {
                                UtilityManager.showAlertMessage("\(error.debugDescription)", onViewcontrolller: self!)
                            }else {
                                UtilityManager.showAlertMessage("Success!", onViewcontrolller: self!)
                                self!.showMain()
                            }
                        })
                    })
                }
            }
            if((error) != nil) {
                print(error, terminator: "")
                if self != nil {
                    self!.dismiss(animated: false, completion: { () -> Void in
                        self!.goToMain()
                    })
                }
            }
        })
    }
    func goToMain(){
        let mycardVc = self.storyboard?.instantiateViewController(withIdentifier: "MyCardsVC") as! MyCardsVC
        let appDelegate = UIApplication.shared().delegate as! AppDelegate
        appDelegate.window?.rootViewController = mycardVc
    }
    func showMain(){
        self.dismiss(animated: true, completion: { () -> Void in
            self.goToMain()
        })
    }
    @IBAction func backButtonTapped(_ sender : UIButton) {
        self.dismiss(animated: true, completion: { () -> Void in
        })
    }
    func isAuthorizedForCamera(_ handler : CameraAccessHandler) {
        if AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo) ==  AVAuthorizationStatus.authorized {
            handler(isGranted: true)
        }else{
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted :Bool) -> Void in
                handler(isGranted: granted)
            });
        }
    }
}
