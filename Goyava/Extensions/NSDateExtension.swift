//
//  NSDateExtension.swift
//  Goyava
//
//  Created by Susim Samanta on 14/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import Foundation
extension Date {
    var mondaysDate: Date {
        let iso8601 =  Calendar(calendarIdentifier: Calendar.Identifier.ISO8601)!
        return iso8601.date(from: iso8601.components([.yearForWeekOfYear, .weekOfYear ], from: Date()))!
    }
    
    var sundayDate : Date {
        let iso8601 =  Calendar(calendarIdentifier: Calendar.Identifier.ISO8601)!
        let sunday = iso8601.date(byAdding: .day, value: 6, to: self.mondaysDate, options: [])
        return sunday!
    }
    
    func dateFromString(_ string : String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss.SSSSxxx"
        let date = dateFormatter.date(from: string)
        return date!
    }
}
