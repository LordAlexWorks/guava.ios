//
//  Shop.swift
//  Goyava
//
//  Created by Susim Samanta on 05/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

class Shop: NSObject {
    var id : Int?
    var name : String?
    var website : String?
    var maximumPoint : Int?
    var logo : String?
    
     func setModelData(dict : NSDictionary) {
        self.id = dict["id"]  as? Int
        self.name = dict["name"] as? String
        self.website = dict["website"] as? String
        self.maximumPoint = dict["maximum_point"] as? Int
        self.logo = dict["logo"] as? String
    }
}
