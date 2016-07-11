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
    //MARK: Token Service
    class func callTokenService(_ code : String,handler :AppServiceHandler) {
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
    class func addClient(_ session: Session, handler: AppServiceHandler) {
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
    class func getAllCardsOfClient(_ client : Client, handler: AppServiceHandler) {
        let getAllCardsURL = "\(URL.baseURL.rawValue)\(URL.apiEndPoint.rawValue)\(client.id)/cards"
        let headerFieldAndValues = ["Content-Type" : "application/x-www-form-urlencoded","Proactives-User-Token": client.token]
        let httpClient = SSHTTPClient(url: getAllCardsURL, method: "GET", httpBody: nil, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (json, error) -> Void in
            if (error != nil) {
                handler(obj: nil,error: error)
            }else {
                handler(obj: json,error: nil)
            }
        }
    }
    
    //MARK: Add QR code service 
    class func addQRCodeActivity(_ client:Client,qrcode: String, shopId:String, handler: AppServiceHandler){
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
    //MARK: Add Card
    class func addCard(_ client:Client,shopId:String, handler: AppServiceHandler){
        let addQRCodeURL = "\(URL.baseURL.rawValue)\(URL.apiEndPoint.rawValue)\(client.id)/cards"
        let headerFieldAndValues = ["Content-Type" : "application/x-www-form-urlencoded","Proactives-User-Token": client.token]
        let httpBody = "shop_id=\(shopId)"
        let httpClient = SSHTTPClient(url: addQRCodeURL, method: "POST", httpBody: httpBody, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (obj, error) -> Void in
            if (error != nil) {
                handler(obj: nil,error: error)
            }else {
                handler(obj: obj,error: nil)
            }
        }
    }
    //MARK: Revoke Auth Token
    static func revokeToken(_ client: Client,appServiceHandler:AppServiceHandler) {
        let revokeTokenURL = URL.proactiveBaseURL.rawValue+URL.proactiveRevokeTokenEndPoint.rawValue
        let headerFieldAndValues = ["Content-Type" : "application/x-www-form-urlencoded","Proactives-User-Token": client.token]
        let httpBody = "proactives_access_token=\(client.token)"
        let httpClient = SSHTTPClient(url: revokeTokenURL, method: "POST", httpBody: httpBody, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (json, error) -> Void in
            if (error != nil) {
                appServiceHandler(obj: nil,error: error)
            }else {
                appServiceHandler(obj: json,error: nil)
            }
        }
    }
}
