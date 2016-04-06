//
//  UtilityManager.swift
//  Goyava
//
//  Created by Susim Samanta on 01/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class UtilityManager: NSObject {
    
    class func getFormattedJSONString(dict : AnyObject) ->NSString {
        do {
            let jsonData = try NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
            return NSString(data: jsonData, encoding: NSUTF8StringEncoding)!
        } catch let error as NSError {
            print(error)
            return ""
        }
    }
    
    class func showAlertMessage(messageString: String, onViewcontrolller:UIViewController) {
        let alert = UIAlertController(title: "Alert", message: messageString, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        onViewcontrolller.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func validateEmail(email :String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluateWithObject(email)
        
    }

}
