//
//  NSDateExtension.swift
//  Goyava
//
//  Created by Susim Samanta on 14/04/16.
//  Copyright © 2016 LordAlexWorks. All rights reserved.
//

import Foundation
extension NSDate {
    func startOfWeek(weekday: Int?) -> NSDate? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components([.YearForWeekOfYear, .WeekOfYear], fromDate: self) else { return nil }
        comp.to12pm()
        cal.firstWeekday = weekday ?? 1
        return cal.dateFromComponents(comp)!
    }
    
    func endOfWeek(weekday: Int) -> NSDate? {
        guard
            let cal: NSCalendar = NSCalendar.currentCalendar(),
            let comp: NSDateComponents = cal.components([.WeekOfYear], fromDate: self) else { return nil }
        comp.weekOfYear = 1
        comp.day -= 1
        comp.to12pm()
        return cal.dateByAddingComponents(comp, toDate: self.startOfWeek(weekday)!, options: [])!
    }
    
}
internal extension NSDateComponents {
    func to12pm() {
        self.hour = 12
        self.minute = 0
        self.second = 0
    }
}