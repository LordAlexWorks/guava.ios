//
//  NSDateExtension.swift
//  Goyava
//
//  Created by Susim Samanta on 14/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import Foundation
extension NSDate {
    var mondaysDate: NSDate {
        let iso8601 =  NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
        return iso8601.dateFromComponents(iso8601.components([.YearForWeekOfYear, .WeekOfYear ], fromDate: NSDate()))!
    }
    
    var sundayDate : NSDate {
        let iso8601 =  NSCalendar(calendarIdentifier: NSCalendarIdentifierISO8601)!
        let sunday = iso8601.dateByAddingUnit(.Day, value: 6, toDate: self.mondaysDate, options: [])
        return sunday!
    }
}
