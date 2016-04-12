//
//  AppServices.swift
//  Goyava
//
//  Created by Susim Samanta on 07/03/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
public typealias AppServiceHandler = (obj : AnyObject? , error : NSError?) -> Void

class AppServices: NSObject {
    //MARK: Login Service
    class func callLoginService(session : Session,handler :AppServiceHandler) {
        let loginURL = URL.baseURL.rawValue+URL.apiEndPoint.rawValue+URL.loginEndPoint.rawValue
        let headerFieldAndValues = ["Content-Type" : "application/json"]
        let jsondict = ["email":session.email!,"password":session.password!]
        let httpBody = UtilityManager.getFormattedJSONString(jsondict)
        let httpClient = SSHTTPClient(url: loginURL, method: "POST", httpBody: httpBody, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (obj, error) -> Void in
            if (error != nil) {
                handler(obj: nil,error: error)
            }else {
                handler(obj: obj,error: nil)
            }
        }
    }
    //MARK: Signup Service
    class func callSignupService(session : Session,handler :AppServiceHandler) {
        let loginURL = URL.baseURL.rawValue+URL.apiEndPoint.rawValue+URL.loginEndPoint.rawValue
        let headerFieldAndValues = ["Content-Type" : "application/json"]
        let jsondict = ["email":session.email!,"password":session.password!]
        let httpBody = UtilityManager.getFormattedJSONString(jsondict)
        let httpClient = SSHTTPClient(url: loginURL, method: "POST", httpBody: httpBody, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (obj, error) -> Void in
            if (error != nil) {
                handler(obj: nil,error: error)
            }else {
                handler(obj: obj,error: nil)
            }
        }
    }
    
    //MARK: Get All Cards
    class func getAllCardsOfUser(user : User, handler: AppServiceHandler) {
        let clientId  = String(user.id)
        let usersCardsURL = URL.baseURL.rawValue+URL.loginEndPoint.rawValue+clientId+URL.cardsEndPoint.rawValue
        let headerFieldAndValues = ["X-User-Email" : user.email, "X-User-Token": user.token]
        let httpClient = SSHTTPClient(url: usersCardsURL, method: "GET", httpBody: nil, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (obj, error) -> Void in
            if (error != nil) {
                handler(obj: nil,error: error)
            }else {
                handler(obj: obj,error: nil)
            }
        }
    }
    
    //MARK: Add QR code service 
    class func addQRCodeActivity(user:User,qrcode: String,merchantId : String, handler: AppServiceHandler){
        let addQRCodeActivityURL = URL.baseURL.rawValue+URL.apiEndPoint.rawValue+URL.loginEndPoint.rawValue
        let headerFieldAndValues = ["X-User-Email" : user.email, "X-User-Token": user.token,"Content-Type" : "application/json"]
        let jsondict = ["activity":["shop_id":merchantId]]
        let httpBody = UtilityManager.getFormattedJSONString(jsondict)
        let httpClient = SSHTTPClient(url: addQRCodeActivityURL, method: "POST", httpBody: httpBody, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (obj, error) -> Void in
            if (error != nil) {
                handler(obj: nil,error: error)
            }else {
                handler(obj: obj,error: nil)
            }
        }
    }
}
