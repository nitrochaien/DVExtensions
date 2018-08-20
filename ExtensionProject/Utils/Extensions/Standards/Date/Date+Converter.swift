//
//  Date+Converter.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension Date {
    // convert date to string with DateFormatter, Locale is VietNam
    func toString(formatter: String, locale: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatter
        dateFormatter.locale = Locale(identifier: locale)
        return dateFormatter.string(from: self)
    }
    
    /// ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSS) from date.
    public var iso8601String: String {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        
        return dateFormatter.string(from: self).appending("Z")
    }
    
    /// Time zone used by system.
    public var timeZone: TimeZone {
        return self.calendar.timeZone
    }
    
    /// UNIX timestamp from date.
    public var unixTimestamp: Double {
        return timeIntervalSince1970
    }
    
    /// Create date object from ISO8601 string.
    ///
    /// - Parameter iso8601String: ISO8601 string of format (yyyy-MM-dd'T'HH:mm:ss.SSSZ).
    public init(iso8601String: String) {
        // https://github.com/justinmakaila/NSDate-ISO-8601/blob/master/NSDateISO8601.swift
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        self = dateFormatter.date(from: iso8601String) ?? Date()
    }
    
    /// Create new date object from UNIX timestamp.
    ///
    /// - Parameter unixTimestamp: UNIX timestamp.
    public init(unixTimestamp: Double) {
        self.init(timeIntervalSince1970: unixTimestamp)
    }
    
    /// Time string from date
    public func timeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = .none
        return dateFormatter.string(from: self)
    }
    
    /// Date string from date.
    ///
    /// - Parameter style: DateFormatter style (default is .medium)
    /// - Returns: date string
    func dateString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .none
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    /// Date and time string from date.
    ///
    /// - Parameter style: DateFormatter style (default is .medium)
    /// - Returns: date and time string
    public func dateTimeString(ofStyle style: DateFormatter.Style = .medium) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = style
        dateFormatter.dateStyle = style
        return dateFormatter.string(from: self)
    }
    
    /// Check if date is in current given calendar component.
    ///
    /// - Parameter component: calendar componenet to check.
    /// - Returns: true if date is in current given calendar component.
    public func isInCurrent(_ component: Calendar.Component) -> Bool {
        switch component {
        case .second:
            return second == Date().second && minute == Date().minute && hour == Date().hour && day == Date().day
                && month == Date().month && year == Date().year && era == Date().era
            
        case .minute:
            return minute == Date().minute && hour == Date().hour && day == Date().day && month == Date().month
                && year == Date().year && era == Date().era
            
        case .hour:
            return hour == Date().hour && day == Date().day && month == Date().month && year == Date().year
                && era == Date().era
            
        case .day:
            return day == Date().day && month == Date().month && year == Date().year && era == Date().era
            
        case .weekOfYear, .weekOfMonth:
            let beginningOfWeek = Date().beginning(of: .weekOfMonth)!
            let endOfWeek = Date().end(of: .weekOfMonth)!
            return self >= beginningOfWeek && self <= endOfWeek
            
        case .month:
            return month == Date().month && year == Date().year && era == Date().era
            
        case .year:
            return year == Date().year && era == Date().era
            
        case .era:
            return era == Date().era
            
        default:
            return false
        }
    }
    
    /// Returns the a custom time interval description from another date
    func offsetDate(from date: Date) -> String {
        let days = self.days(from: date)
        if days > 0 {
            if days == 1 {
                return "\(days) day"
            }
            return "\(days) days"
        }
        
        let hours = self.hours(from: date)
        if hours > 0 {
            if hours == 1 {
                return "\(hours) hour"
            }
            return "\(hours) hours"
        }
        
        let minutes = self.minutes(from: date)
        if minutes > 0 {
            if minutes == 1 {
                return "\(minutes) minute"
            }
            return "\(minutes) minutes"
        }
        
        let seconds = self.seconds(from: date)
        if seconds > 0 {
            if seconds == 1 {
                return "\(seconds) second"
            }
            return "\(seconds) seconds"
        }
        return ""
    }
}
