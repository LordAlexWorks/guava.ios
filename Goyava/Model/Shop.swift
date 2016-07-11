//
//  Shop.swift
//  Goyava
//
//  Created by Susim Samanta on 05/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift

class Shop: Object {
    dynamic var id = 0
    dynamic var name = ""
    dynamic var website = ""
    dynamic var maximumPoint = 0
    dynamic var logo  = ""
    
     func setModelData(_ dict : NSDictionary) {
        self.id = dict["id"]  as! Int
        self.name = dict["name"] as! String
        self.website = dict["website"] as! String
        self.maximumPoint = dict["maximum_point"] as! Int
        self.logo = dict["logo"] as! String
    }
}
