//
//  Login.swift
//  Guava
//
//  Created by Susim Samanta on 02/02/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class Session: NSObject {
    var token : String?
    var isSuccess : Bool?
    var errorDescription : String?
    
    func setModelData(dict : NSDictionary) {
        self.errorDescription = dict["error_description"] as? String
        self.token = dict["access_token"] as? String
        if self.errorDescription != nil {
            self.isSuccess = false
        }else if token != nil {
            self.isSuccess = true
        }
    }
}
