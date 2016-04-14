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
                print(result)
                if self != nil {
                    Loader.sharedInstance.showLoader()
                    ActivitiesController.addQRCodeActivity(result, handler: { (obj, error) in
                        dispatch_async(dispatch_get_main_queue(),{
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
                print(error)
                if self != nil {
                    self!.dismissViewControllerAnimated(false, completion: { () -> Void in
                        self!.goToMain()
                    })
                }
            }
        })
    }
    func goToMain(){
        let mycardVc = self.storyboard?.instantiateViewControllerWithIdentifier("MyCardsVC") as! MyCardsVC
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = mycardVc
    }
    func showMain(){
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
            self.goToMain()
        })
    }
    @IBAction func backButtonTapped(sender : UIButton) {
        self.dismissViewControllerAnimated(true, completion: { () -> Void in
        })
    }
    func isAuthorizedForCamera(handler : CameraAccessHandler) {
        if AVCaptureDevice.authorizationStatusForMediaType(AVMediaTypeVideo) ==  AVAuthorizationStatus.Authorized {
            handler(isGranted: true)
        }else{
            AVCaptureDevice.requestAccessForMediaType(AVMediaTypeVideo, completionHandler: { (granted :Bool) -> Void in
                handler(isGranted: granted)
            });
        }
    }
}
