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
        UIApplication.shared().isNetworkActivityIndicatorVisible = true
        let appDelegate = UIApplication.shared().delegate as! AppDelegate
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.loaderView = UIView(frame: CGRect(origin: CGPoint(x: (appDelegate.window?.center.x)!-40, y: (appDelegate.window?.center.y)!-40), size: CGSize(width: 80, height: 80)))
        self.loaderView!.backgroundColor = UIColor.black()
        self.loaderView!.layer.cornerRadius = 8.0
        self.loaderView!.clipsToBounds = true
        activityIndicator.center = CGPoint(x: 40, y: 40)
        self.loaderView!.addSubview(activityIndicator)
        appDelegate.window?.addSubview(self.loaderView!)
        activityIndicator.startAnimating()
    }
    func hideLoader(){
        UIApplication.shared().isNetworkActivityIndicatorVisible = false
        self.loaderView?.removeFromSuperview()
        self.loaderView = nil
    }
    
}
