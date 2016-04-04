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
    
    func setModelData(dict : NSDictionary) {
        self.id = dict["id"] as? Int
        self.maxPoint = dict["max_point"] as? Int
        self.point = dict["point"] as? Int
    }
}
