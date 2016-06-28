//
//  AuthenticationController.swift
//  Goyava
//
//  Created by Susim Samanta on 01/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift
typealias AuthenticationHandler = (session : Session? , error : NSError?) -> Void

class AuthenticationController: NSObject {
    
    //MARK: Login controller method
    class func getSession(code : String, handler : AuthenticationHandler){
        AppServices.callTokenService(code) { (json, error) -> Void in
            if error != nil {
                handler(session: nil,error: error)
            }else {
                let session = Session()
                session.setModelData(json as! NSDictionary)
                handler(session: session,error: error)
            }
        }
    }
    
    class func getLocalUser()-> User? {
        let realm = try! Realm()
        return realm.objects(User).first
    }
    class func getProactiveAuthURL() -> String {
        let authURL = "\(URL.proactiveBaseURL.rawValue)\(URL.proactiveAuthEndPoint.rawValue)client_id=\(ApplicationSecrets.ApplicationId.rawValue)&redirect_uri==\(ApplicationSecrets.callBackURL.rawValue)&response_type=code"
        return authURL
    }
}
