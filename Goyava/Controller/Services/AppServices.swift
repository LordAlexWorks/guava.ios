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
    class func callTokenService(code : String,handler :AppServiceHandler) {
        let tokenURL = URL.proactiveBaseURL.rawValue+URL.proactiveTokenEndPoint.rawValue
        let headerFieldAndValues = ["Content-Type" : "application/x-www-form-urlencoded"]
        let httpBody = "code=\(code)&redirect_uri=\(ApplicationSecrets.callBackURL.rawValue)&client_id=\(ApplicationSecrets.ApplicationId.rawValue)&grant_type=authorization_code&client_secret=\(ApplicationSecrets.ApplicationSecret.rawValue)"
        let httpClient = SSHTTPClient(url: tokenURL, method: "POST", httpBody: httpBody, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (json, error) -> Void in
            if (error != nil) {
                handler(obj: nil,error: error)
            }else {
                handler(obj: json,error: nil)
            }
        }
    }
    class func addClient(session: Session, handler: AppServiceHandler) {
        let addClientURL = URL.baseURL.rawValue+URL.apiEndPoint.rawValue
        let headerFieldAndValues = ["Content-Type" : "application/x-www-form-urlencoded","Proactives-User-Token": session.token!]
        let httpBody = "proactives_access_token=\(session.token!)"
        let httpClient = SSHTTPClient(url: addClientURL, method: "POST", httpBody: httpBody, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (json, error) -> Void in
            if (error != nil) {
                handler(obj: nil,error: error)
            }else {
                handler(obj: json,error: nil)
            }
        }
    }
    //MARK: Get All Cards
    class func getAllCardsOfClient(client : Client, handler: AppServiceHandler) {
        let clientId  = String(client.id)
        let usersCardsURL = URL.baseURL.rawValue
        let headerFieldAndValues = ["X-User-Token": client.token]
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
    class func addQRCodeActivity(client:Client,qrcode: String, shopId:String, handler: AppServiceHandler){
        let addQRCodeURL = "\(URL.baseURL.rawValue)\(URL.apiEndPoint.rawValue)\(client.id)/activities"
        let headerFieldAndValues = ["Content-Type" : "application/x-www-form-urlencoded","Proactives-User-Token": client.token]
        let httpBody = "shop_id=\(shopId)&stamp_id=\(qrcode)"
        let httpClient = SSHTTPClient(url: addQRCodeURL, method: "POST", httpBody: httpBody, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (obj, error) -> Void in
            if (error != nil) {
                handler(obj: nil,error: error)
            }else {
                handler(obj: obj,error: nil)
            }
        }
    }
}
