//
//  User.swift
//  Goyava
//
//  Created by Susim Samanta on 04/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift

class Client: Object {
    dynamic var id = 0 //it's client_id
    dynamic var token = ""
    var myCards = List<Card>()
    
    func setModelData(_ dict : NSDictionary) {
        self.id = dict["id"] as! Int
        let cards = dict["cards"] as! NSArray
        self.myCards = CardsController.getMyCards(cards)
    }
}
