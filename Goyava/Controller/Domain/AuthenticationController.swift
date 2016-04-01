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
    
    //MARK: Login controller method
    class func doLogin(login : Login, handler : AuthenticationHandler){
        AppServices.callLoginService(login) { (obj, error) -> Void in
            if error != nil {
                handler(obj: nil,error: error)
            }else {
                // do bussiness logic with login json response
                let json = obj as! NSDictionary
                let error = json["errors"]
                if error != nil {
                   login.isSuccess = false
                }else {
                    login.isSuccess = true
                }
                handler(obj: login, error: nil)
            }
        }
    }
    
    //MARK: Signup controller method
    class func doSignup(login : Login, handler : AuthenticationHandler){
        AppServices.callSignupService(login) { (obj, error) -> Void in
            if error != nil {
                handler(obj: nil,error: error)
            }else {
                // do bussiness logic with signup json response
                let json = obj as! NSDictionary
                let userid = json["client"]!["id"]
                if userid != nil {
                    login.isSuccess = false
                }else {
                    login.isSuccess = true
                }
                handler(obj: login, error: nil)
            }
        }
    }
}
