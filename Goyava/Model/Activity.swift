//
//  Activity.swift
//  Goyava
//
//  Created by Susim Samanta on 05/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift

class Activity: Object {
    //dynamic var createdAt = NSDate()
    dynamic var createdAt = ""
    dynamic var point = 0
    
    func setModelData(dict : NSDictionary) {
        /*let createAtDateString = dict["created_at"] as! String
        self.createdAt = self.createdAt.dateFromString(createAtDateString)*/
        self.createdAt = dict["created_at"] as! String
        self.point = dict["point"] as! Int
    }
}
