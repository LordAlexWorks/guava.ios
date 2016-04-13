//
//  Card.swift
//  Goyava
//
//  Created by Susim Samanta on 04/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift

class Card: Object {
    dynamic var id = 0
    dynamic var maxPoint = 0
    dynamic var point = 0
    dynamic var shop : Shop?
    var activities = List<Activity>()
    
    func setModelData(dict : NSDictionary) {
        self.id = dict["id"] as! Int
        self.maxPoint = dict["max_point"] as! Int
        self.point = dict["point"] as! Int
        self.shop = CardsController.getMyShop(dict["shop"] as! NSDictionary)
    }
}
