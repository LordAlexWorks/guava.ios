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
typealias ClientHandler = (client : Client? , error : NSError?) -> Void
typealias LogoutHandler = (isFinishedLogout : Bool) -> Void
class AuthenticationController: NSObject {
    
    //MARK: Login controller method
    class func getSession(_ code : String, handler : AuthenticationHandler){
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
    class func addClient(_ session :Session, clientHandler: ClientHandler) {
        AppServices.addClient(session) { (json, error) in
            if error != nil {
                clientHandler(client: nil, error: error)
            }else {
                let client = Client()
                client.token = session.token!
                let clientDict = json!["client"] as! NSDictionary
                client.setModelData(clientDict)
                clientHandler(client: client, error: nil)
            }
        }
    }
    class func getLocalClient()-> Client? {
        let realm = try! Realm()
        return realm.objects(Client).first
    }
    class func getProactiveAuthURL() -> String {
        let authURL = "\(URL.proactiveBaseURL.rawValue)\(URL.proactiveAuthEndPoint.rawValue)client_id=\(ApplicationSecrets.ApplicationId.rawValue)&redirect_uri=\(ApplicationSecrets.callBackURL.rawValue)&response_type=code"
        return authURL
    }
    class func logout(_ logoutHandler: LogoutHandler){
        let client = self.getLocalClient()
        AppServices.revokeToken(client!) { (obj, error) in
            if error != nil {
                logoutHandler(isFinishedLogout: false)
                print(error)
            }else {
                logoutHandler(isFinishedLogout: true)
                print(obj)
            }
        }
    }
}
