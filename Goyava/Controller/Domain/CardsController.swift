//
//  CardsController.swift
//  Goyava
//
//  Created by Susim Samanta on 04/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit

public typealias CardsHandler = (obj : AnyObject? , error : NSError?) -> Void

class CardsController: NSObject {
    //get all cards from current session
    class func getAllCards(handler : CardsHandler) {
        AppServices.getAllCardsOfUser(User.sharedInstance) { (obj, error) in
            if error != nil {
                handler(obj: nil, error: error)
            }else {
                //parse card object
                let json = obj as! NSDictionary
                let cards = json["cards"] as! NSArray
                handler(obj: self.getMyCards(cards), error: nil)
            }
        }
    }
    class func getMyCards(cards : NSArray) ->[Card] {
        var cardsList = [Card]()
        for item in cards {
            let card = Card()
            card.setModelData(item as! NSDictionary)
            cardsList.append(card)
        }
        return cardsList
    }
    class func getMyShop(shopDict : NSDictionary)-> Shop {
        let shop = Shop()
        shop.setModelData(shopDict)
        return shop
    }
}
