//
//  AuthenticationController.swift
//  Goyava
//
//  Created by Susim Samanta on 01/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
public typealias AuthenticationHandler = (obj : AnyObject? , error : NSError?) -> Void

class AuthenticationController: NSObject {
    
    class func doLogin(login : Login, handler : AuthenticationHandler){
        AppServices.callLoginService(login) { (obj, error) -> Void in
            if error != nil {
                handler(obj: nil,error: error)
            }else {
                // do business logic with login json response
                handler(obj: obj, error: nil)
            }
        }
    }
}
