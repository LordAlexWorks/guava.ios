//
//  Keyboard.swift
//  Goyava
//
//  Created by Susim Samanta on 03/05/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

public typealias ShowKeyboardHandler = (notification : NSNotification) -> Void
public typealias HideKeyboardHandler = (notification : NSNotification) -> Void

class Keyboard: NSObject {
    
    //keyboard show and hide handlers
    static var showKeyboardHandler : ShowKeyboardHandler?
    static var hidekyeboardHandler : HideKeyboardHandler?
    
    //Keyboard register method with show and hide notification
    static func resgister(viewController : UIViewController, showKeyboard showKeyboardHandler : ShowKeyboardHandler, hideKeyboard hideKeyboardHandler : HideKeyboardHandler) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name:UIKeyboardWillShowNotification, object: nil);
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name:UIKeyboardWillHideNotification, object: nil);
        self.showKeyboardHandler =  showKeyboardHandler
        self.hidekyeboardHandler = hideKeyboardHandler
    }
    
    //keyboard show method
    static func keyboardWillShow(notification: NSNotification) {
        self.showKeyboardHandler!(notification: notification)
    }
    
    //keyboard hide method
    static func keyboardWillHide(notification: NSNotification) {
        self.hidekyeboardHandler!(notification: notification)
    }
}
