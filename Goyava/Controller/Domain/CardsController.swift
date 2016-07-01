//
//  CardsController.swift
//  Goyava
//
//  Created by Susim Samanta on 04/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift
public typealias CardsHandler = (obj : AnyObject? , error : NSError?) -> Void

class CardsController: NSObject {
    //get all cards from current session
    class func getAllCards(handler : CardsHandler) {
        let client = Client()
        AppServices.getAllCardsOfClient(client) { (obj, error) in
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
    class func getMyCards(cards : NSArray) -> List<Card> {
        let cardsList = List<Card>()
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
    class func addCard(shopId : String,cardHandler :CardsHandler) {
        let client = AuthenticationController.getLocalClient()
        AppServices.addCard(client!, shopId: shopId) { (obj, error) in
            if error != nil {
                cardHandler(obj: nil, error: error)
            }else {
                cardHandler(obj: "isSuccess", error: nil)
            }
        }
    }
    class func scanCard(qrcode: String,cardHandler :CardsHandler) {
        
    }
}
