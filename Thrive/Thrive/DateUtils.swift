//
//  DateUtils.swift
//  Thrive
//
//  Created by Jonathan Lu on 3/5/16.
//  Copyright © 2016 UCSC OpenLab. All rights reserved.
//

import Foundation

class DateUtils {
    // formats a MongoDB date into an NSDate
    static func getDateFromString(rawDate: String) -> NSDate? {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter.dateFromString(rawDate)
    }
    
    static func getPrettyLongDate(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .ShortStyle
        
        return formatter.stringFromDate(date);
    }
}