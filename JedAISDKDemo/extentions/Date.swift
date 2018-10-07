//
//  Date.swift
//  JedAISDKDemo
//
//  Created by Izchak Witman on 07/10/2018.
//  Copyright © 2018 DeveloperMBP. All rights reserved.
//

import Foundation


/* Helpful date/time DateFormatter.style descriptions:
 // .none: show nothing
 // .short: “11/23/37” / “3:30 PM”
 // .medium: "Nov 23, 1937" / "3:30:32 PM"
 // .long: "November 23, 1937" / "3:30:32 PM PST"
 // .full: "Tuesday, April 12, 1952 AD" / "3:30:42 PM Pacific Standard Time"
 */
// MARK: - Helpful date translation methods.
extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    /// Converts Date to String by passing dateStyle and timeStyle formats.
    /// Default is none.
    func string(dateStyle: DateFormatter.Style = .short, timeStyle: DateFormatter.Style = .short) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter.string(from: self)
    }
    
    var timelineTitle: String {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "E, MMM d"
        let str = formatter.string(from: self)
        return calendar.isDateInToday(self) ? "Today"
            : calendar.isDateInYesterday(self) ? "Yesterday"
            : str
    }
    
    //    returns date of start of current date's day
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    //    returns date of end of current date's day
    var endOfDay: Date {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)!
    }
}

extension Int {
    /// Convert integer timestamp to date
    func decodeTimestamp() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}

typealias Timestamp =  Int64

extension Timestamp {
    func decodeTimestamp() -> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
