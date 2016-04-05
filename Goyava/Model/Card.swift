//
//  Card.swift
//  Goyava
//
//  Created by Susim Samanta on 04/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit


class Card: NSObject {
    var id : Int?
    var maxPoint : Int?
    var point : Int?
    var shop : Shop?
    var activities : [Activity]?
    
    func setModelData(dict : NSDictionary) {
        self.id = dict["id"] as? Int
        self.maxPoint = dict["max_point"] as? Int
        self.point = dict["point"] as? Int
        self.shop = CardsController.getMyShop(dict["shop"] as! NSDictionary)
    }
}
