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
    class func callLoginService(login : Login,handler :AppServiceHandler) {
        let loginURL = URL.baseURL.rawValue+URL.loginEndPoint.rawValue
        let headerFieldAndValues = ["Content-Type" : "application/json"]
        let jsondict = ["email":login.username!,"password":login.password!]
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
}
