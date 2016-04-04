//
//  Loader.swift
//  OneIOS
//
//  Created by Susim Samanta on 03/02/16.
//  Copyright © 2016 SusimSamanta. All rights reserved.
//

import UIKit

class Loader: NSObject {
    static let sharedInstance = Loader()
    var loaderView: UIView?
    func showLoader(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.WhiteLarge
        self.loaderView = UIView(frame: CGRect(origin: CGPoint(x: (appDelegate.window?.center.x)!-40, y: (appDelegate.window?.center.y)!-40), size: CGSize(width: 80, height: 80)))
        self.loaderView!.backgroundColor = UIColor.blackColor()
        self.loaderView!.layer.cornerRadius = 8.0
        self.loaderView!.clipsToBounds = true
        activityIndicator.center = CGPoint(x: 40, y: 40)
        self.loaderView!.addSubview(activityIndicator)
        appDelegate.window?.addSubview(self.loaderView!)
        activityIndicator.startAnimating()
    }
    func hideLoader(){
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        self.loaderView?.removeFromSuperview()
        self.loaderView = nil
    }
    
}
