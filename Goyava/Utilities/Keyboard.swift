//
//  Keyboard.swift
//  Goyava
//
//  Created by Susim Samanta on 03/05/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class Keyboard: NSObject {
    
    //view controller 
    static var viewController : UIViewController?
    
    //Keyboard register method with show and hide notification
    static func showHide(viewController : UIViewController) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        self.viewController = viewController
    }
    
    //keyboard show method
    static func keyboardWillShow(notification: NSNotification) {
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        let viewFrame = self.viewController!.view.frame
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.viewController!.view.frame = CGRect(x: 0, y: -keyboardFrame.height+140, width: viewFrame.size.width, height: viewFrame.size.height)
        })
    }
    
    //keyboard hide method
    static func keyboardWillHide(notification: NSNotification) {
        let viewFrame = self.viewController!.view.frame
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.viewController!.view.frame = CGRect(x: 0, y: 0, width: viewFrame.size.width, height: viewFrame.size.height)
        })
    }
}
