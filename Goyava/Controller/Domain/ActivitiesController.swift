//
//  ActivitiesController.swift
//  Goyava
//
//  Created by Susim Samanta on 04/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import UIKit
import RealmSwift

public typealias ActivityHandler = (obj : AnyObject? , error : NSError?) -> Void

class ActivitiesController: NSObject {
    class func addQRCodeActivity(qrCode: String, handler: ActivityHandler){
        let qrCodeComponenets = qrCode.componentsSeparatedByString("//")
        if qrCodeComponenets.count == 3 {
            let qrid = qrCodeComponenets[2]
            let shopId = qrCodeComponenets[1]
            let appDel = UIApplication.sharedApplication().delegate as! AppDelegate
            AppServices.addQRCodeActivity(appDel.user!, qrcode: qrid, merchantId: shopId, handler: { (obj, error) in
                if error != nil {
                   handler(obj: nil, error: error)
                }else {
                    let json = obj as! NSDictionary
                    let error = json["errors"]
                    if error != nil {
                        handler(obj: nil, error:  NSError(domain: "io.proactives.guava.QRCodeError", code: 1001, userInfo: ["description":"Guava add QRcode service error."]))
                    }else {
                        let activityDict = json["activity"] as! NSDictionary
                        let activity = Activity()
                        activity.setModelData(activityDict)
                        handler(obj: activity, error: nil)
                    }
                }
            })
        }else {
            handler(obj: nil, error:  NSError(domain: "io.proactives.guava.QRCodeError", code: 1000, userInfo: ["description":"Guava QRcode domain conventation error."]))
        }
    }
    
    class func getGlobalPoint(card : Card) -> Int {
        var globalPoint = 0
        let activities = card.activities
        for item in activities {
            let acitvity = item
            globalPoint = globalPoint+acitvity.point
        }
        return globalPoint
    }
    
    class func getWeeklyPoint(card : Card)-> Int {
        let mondayTimeStamp = NSDate().mondaysDate.timeIntervalSince1970
        let results = card.activities.filter("createdAt >= \(mondayTimeStamp)")
        var weeklyTotal = 0
        for item in results {
            let activity = item 
            weeklyTotal = weeklyTotal + activity.point
        }
        return weeklyTotal
    }
}
