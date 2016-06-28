//
//  User.swift
//  Goyava
//
//  Created by Susim Samanta on 04/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift

class User: Object {
    dynamic var id = 0
    dynamic var token = ""
    var myCards = List<Card>()
    
    func setModelData(dict : NSDictionary) {
        self.id = dict["id"] as! Int
        self.token = dict["token"] as! String
        //let cards = dict["cards"] as! NSArray
        //self.myCards = CardsController.getMyCards(cards)
    }
}
