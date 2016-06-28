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
        let tokeURL = URL.proactiveBaseURL.rawValue+URL.proactiveTokenEndPoint.rawValue
        let headerFieldAndValues = ["Content-Type" : "application/x-www-form-urlencoded"]
        let httpBody = "code=\(code)&redirect_uri=\(ApplicationSecrets.callBackURL.rawValue)&client_id=\(ApplicationSecrets.ApplicationId.rawValue)&grant_type=authorization_code&client_secret=\(ApplicationSecrets.ApplicationSecret.rawValue)"
        let httpClient = SSHTTPClient(url: tokeURL, method: "POST", httpBody: httpBody, headerFieldsAndValues: headerFieldAndValues)
        httpClient.getJsonData { (json, error) -> Void in
            if (error != nil) {
                handler(obj: nil,error: error)
            }else {
                handler(obj: json,error: nil)
            }
        }
    }
    
    //MARK: Get All Cards
    class func getAllCardsOfUser(user : User, handler: AppServiceHandler) {
        let clientId  = String(user.id)
        let usersCardsURL = URL.baseURL.rawValue
        let headerFieldAndValues = ["X-User-Token": user.token]
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
        let addQRCodeActivityURL = URL.baseURL.rawValue+URL.apiEndPoint.rawValue+"\(user.id)/qrcodes/\(qrcode)/"+URL.activityEndPoint.rawValue
        let headerFieldAndValues = ["X-User-Token": user.token,"Content-Type" : "application/json"]
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
