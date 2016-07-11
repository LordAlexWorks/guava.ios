//
//  UtilityManager.swift
//  Goyava
//
//  Created by Susim Samanta on 01/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class UtilityManager: NSObject {
    
    class func getFormattedJSONString(_ dict : AnyObject) ->NSString {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
            return NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)!
        } catch let error as NSError {
            print(error)
            return ""
        }
    }
    
    class func showAlertMessage(_ messageString: String, onViewcontrolller:UIViewController) {
        let alert = UIAlertController(title: "Alert", message: messageString, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        onViewcontrolller.present(alert, animated: true, completion: nil)
    }
    
    class func showErrorAlertMessage(_ messageString: String, onViewcontrolller:UIViewController) {
        let alert = UIAlertController(title: "Oops!", message: messageString, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        onViewcontrolller.present(alert, animated: true, completion: nil)
    }
    
    class func validateEmail(_ email :String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = Predicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPredicate.evaluate(with: email)
        
    }
    class func drawCircularImage(_ image :UIImageView) {
        image.layer.borderWidth = 0.0
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.red().cgColor
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
    }
    class func addAttributedPlacehoder(_ emailTextField : UITextField, passwordTextField : UITextField) {
        emailTextField.attributedPlaceholder = AttributedString(string: "EMAIL", attributes: [NSForegroundColorAttributeName : UIColor.gray()])
        passwordTextField.attributedPlaceholder = AttributedString(string: "PASSWORD", attributes: [NSForegroundColorAttributeName : UIColor.gray()])
    }

}
