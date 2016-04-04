//
//  User.swift
//  Goyava
//
//  Created by Susim Samanta on 04/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class User: NSObject {
    static let sharedInstance = User()
    var clientId : Int?
    var email : String?
    var username : String?
    var token : String?
    
    func setModelData(dict : NSDictionary) {
        self.clientId = dict["id"] as? Int
        self.email = dict["email"] as? String
        self.username = dict["username"] as? String
        self.token = dict["token"] as? String
    }
}
