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
    dynamic var email = ""
    dynamic var username : String = ""
    dynamic var token = ""
    //var myCards : [Card]?
    
    func setModelData(dict : NSDictionary) {
        self.id = dict["id"] as! Int
        self.email = dict["email"] as! String
        self.username = dict["username"] as! String
        self.token = dict["token"] as! String
        /*let cards = dict["cards"] as! NSArray
        self.myCards = CardsController.getMyCards(cards)*/
    }
}
