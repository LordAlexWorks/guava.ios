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
    static func showHide(_ viewController : UIViewController) {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
        self.viewController = viewController
    }
    
    //keyboard show method
    static func keyboardWillShow(_ notification: Notification) {
        let info = (notification as NSNotification).userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue()
        let viewFrame = self.viewController!.view.frame
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.viewController!.view.frame = CGRect(x: 0, y: -keyboardFrame.height+140, width: viewFrame.size.width, height: viewFrame.size.height)
        })
    }
    
    //keyboard hide method
    static func keyboardWillHide(_ notification: Notification) {
        let viewFrame = self.viewController!.view.frame
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.viewController!.view.frame = CGRect(x: 0, y: 0, width: viewFrame.size.width, height: viewFrame.size.height)
        })
    }
}
