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
    var id : Int? = nil
    var email : String?
    var username : String?
    var token : String?
    //var myCards : [Card]?
    
    func setModelData(dict : NSDictionary) {
        self.id = dict["id"] as? Int
        self.email = dict["email"] as? String
        self.username = dict["username"] as? String
        self.token = dict["token"] as? String
        /*let cards = dict["cards"] as! NSArray
        self.myCards = CardsController.getMyCards(cards)*/
    }
}
