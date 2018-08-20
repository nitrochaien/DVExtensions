//
//  Date+Ext.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension Date {
    func surpass(_ date: Date) -> Bool {
        return timeIntervalSince1970 > date.timeIntervalSince1970
    }
    
    func equalOrSurpass(_ date: Date) -> Bool {
        return timeIntervalSince1970 >= date.timeIntervalSince1970
    }
    
    func lessThan(_ date: Date) -> Bool {
        return !equalOrSurpass(date)
    }
    
    func equalOrLessThan(_ date: Date) -> Bool {
        return !surpass(date)
    }
    
    /// Nearest five minutes to date.
    public var nearestFiveMinutes: Date {
        var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        guard let min = components.minute else {
            return self
        }
        components.minute! = min % 5 < 3 ? min - min % 5 : min + 5 - (min % 5)
        components.second = 0
        if min > 57 {
            components.hour? += 1
        }
        return Calendar.current.date(from: components) ?? Date()
    }
    
    /// Nearest ten minutes to date.
    public var nearestTenMinutes: Date {
        var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        guard let min = components.minute else {
            return self
        }
        components.minute! = min % 10 < 6 ? min - min % 10 : min + 10 - (min % 10)
        components.second = 0
        if min > 55 {
            components.hour? += 1
        }
        return Calendar.current.date(from: components) ?? Date()
    }
    
    /// Nearest quarter to date.
    public var nearestHourQuarter: Date {
        var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        guard let min = components.minute else {
            return self
        }
        components.minute! = min % 15 < 8 ? min - min % 15 : min + 15 - (min % 15)
        components.second = 0
        if min > 52 {
            components.hour? += 1
        }
        return Calendar.current.date(from: components) ?? Date()
    }
    
    /// Nearest half hour to date.
    public var nearestHalfHour: Date {
        var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        guard let min = components.minute else {
            return self
        }
        components.minute! = min % 30 < 15 ? min - min % 30 : min + 30 - (min % 30)
        components.second = 0
        if min > 30 {
            components.hour? += 1
        }
        return Calendar.current.date(from: components) ?? Date()
    }
    
    
    /// Rounded to next quarter hour (Ex: 7 -> 15, 12 -> 15, 16 -> 30,...)
    var nextQuarterHour: Date {
        var components = Calendar.current.dateComponents([.year, .month , .day , .hour , .minute], from: self)
        guard let min = components.minute else {
            return self
        }
        if min % 15 != 0 {
            components.minute = min + 15 - (min % 15)
        }
        components.second = 0
        if min > 45 {
            components.hour? += 1
            components.minute = 0
        }
        return Calendar.current.date(from: components) ?? Date()
    }
    
    /// Add calendar component to date.
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of compnenet to add.
    public mutating func add(_ component: Calendar.Component, value: Int) {
        switch component {
        case .second:
            self = calendar.date(byAdding: .second, value: value, to: self) ?? self
            break
            
        case .minute:
            self = calendar.date(byAdding: .minute, value: value, to: self) ?? self
            break
            
        case .hour:
            self = calendar.date(byAdding: .hour, value: value, to: self) ?? self
            break
            
        case .day:
            self = calendar.date(byAdding: .day, value: value, to: self) ?? self
            break
            
        case .weekOfYear, .weekOfMonth:
            self = calendar.date(byAdding: .day, value: value * 7, to: self) ?? self
            break
            
        case .month:
            self = calendar.date(byAdding: .month, value: value, to: self) ?? self
            break
            
        case .year:
            self = calendar.date(byAdding: .year, value: value, to: self) ?? self
            break
            
        default:
            break
        }
    }
    
    /// Date by adding multiples of calendar component.
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: multiples of compnenets to add.
    /// - Returns: original date + multiples of compnenet added.
    public func adding(_ component: Calendar.Component, value: Int) -> Date {
        switch component {
        case .second:
            return calendar.date(byAdding: .second, value: value, to: self) ?? self
            
        case .minute:
            return calendar.date(byAdding: .minute, value: value, to: self) ?? self
            
        case .hour:
            return calendar.date(byAdding: .hour, value: value, to: self) ?? self
            
        case .day:
            return calendar.date(byAdding: .day, value: value, to: self) ?? self
            
        case .weekOfYear, .weekOfMonth:
            return calendar.date(byAdding: .day, value: value * 7, to: self) ?? self
            
        case .month:
            return calendar.date(byAdding: .month, value: value, to: self) ?? self
            
        case .year:
            return calendar.date(byAdding: .year, value: value, to: self) ?? self
            
        default:
            return self
        }
    }
    
    /// Date by changing value of calendar component.
    ///
    /// - Parameters:
    ///   - component: component type.
    ///   - value: new value of compnenet to change.
    /// - Returns: original date + multiples of compnenets added.
    public func changing(_ component: Calendar.Component, value: Int) -> Date {
        switch component {
        case .second:
            var date = self
            date.second = value
            return date
            
        case .minute:
            var date = self
            date.minute = value
            return date
            
        case .hour:
            var date = self
            date.hour = value
            return date
            
        case .day:
            var date = self
            date.day = value
            return date
            
        case .month:
            var date = self
            date.month = value
            return date
            
        case .year:
            var date = self
            date.year = value
            return date
            
        default:
            return self
        }
    }
    
    /// Data at the beginning of calendar component.
    ///
    /// - Parameter component: calendar component to get date at the beginning of.
    /// - Returns: date at the beginning of calendar component (if applicable).
    public func beginning(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self))
            
        case .minute:
            return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: self))
            
        case .hour:
            return calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: self))
            
        case .day:
            return self.calendar.startOfDay(for: self)
            
        case .weekOfYear, .weekOfMonth:
            return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))
            
        case .month:
            return calendar.date(from: calendar.dateComponents([.year, .month], from: self))
            
        case .year:
            return calendar.date(from: calendar.dateComponents([.year], from: self))
            
        default:
            return nil
        }
    }
    
    /// Date at the end of calendar component.
    ///
    /// - Parameter component: calendar component to get date at the end of.
    /// - Returns: date at the end of calendar component (if applicable).
    public func end(of component: Calendar.Component) -> Date? {
        switch component {
        case .second:
            var date = self.adding(.second, value: 1)
            guard let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)) else {
                return nil
            }
            date = after
            date.add(.second, value: -1)
            return date
            
        case .minute:
            var date = self.adding(.minute, value: 1)
            guard let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)) else {
                return nil
            }
            date = after.adding(.second, value: -1)
            return date
            
        case .hour:
            var date = self.adding(.hour, value: 1)
            guard let after = calendar.date(from: calendar.dateComponents([.year, .month, .day, .hour], from: self)) else {
                return nil
            }
            date = after.adding(.second, value: -1)
            return date
            
        case .day:
            var date = self.adding(.day, value: 1)
            date = date.calendar.startOfDay(for: date)
            date.add(.second, value: -1)
            return date
            
        case .weekOfYear, .weekOfMonth:
            var date = self
            guard let beginningOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else {
                return nil
            }
            date = beginningOfWeek.adding(.day, value: 7).adding(.second, value: -1)
            return date
            
        case .month:
            var date = self.adding(.month, value: 1)
            guard let after = calendar.date(from: calendar.dateComponents([.year, .month], from: self)) else {
                return nil
            }
            date = after.adding(.second, value: -1)
            return date
            
        case .year:
            var date = self.adding(.year, value: 1)
            guard let after = calendar.date(from: calendar.dateComponents([.year], from: self)) else {
                return nil
            }
            date = after.adding(.second, value: -1)
            return date
            
        default:
            return nil
        }
    }
    
    /// SwiftRandom extension
    public static func randomWithinDaysBeforeToday(_ days: Int) -> Date {
        let today = Date()
        let gregorian = Calendar(identifier: Calendar.Identifier.gregorian)
        
        let r1 = arc4random_uniform(UInt32(days))
        let r2 = arc4random_uniform(UInt32(23))
        let r3 = arc4random_uniform(UInt32(59))
        let r4 = arc4random_uniform(UInt32(59))
        
        var offsetComponents = DateComponents()
        offsetComponents.day = Int(r1) * -1
        offsetComponents.hour = Int(r2)
        offsetComponents.minute = Int(r3)
        offsetComponents.second = Int(r4)
        
        guard let rndDate1 = gregorian.date(byAdding: offsetComponents, to: today) else {
            print("randoming failed")
            return today
        }
        return rndDate1
    }
    
    /// SwiftRandom extension
    public static func random() -> Date {
        let randomTime = TimeInterval(arc4random_uniform(UInt32.max))
        return Date(timeIntervalSince1970: randomTime)
    }
}
