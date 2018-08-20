//
//  String+Date.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension String {
    /// Convert String to DateComponents of year, month, day and hour
    ///
    /// - Parameter dateFormat: Date string
    /// - Returns: DateComponents
    func toDateComponents(_ dateFormat: String) -> DateComponents {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        let date = dateFormatter.date(from: self)
        let calendar = Calendar.current
        return calendar.dateComponents([.year, .month, .day, .hour], from: date!)
    }
    
    /// Convert String from Date format kyyyyMMdd_hhmmss to format kyyyyMMdd_hhmm
    ///
    /// - Returns: Validated Date string
    func validDisplayTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.kyyyyMMdd_hhmmss
        if let date = dateFormatter.date(from: self) {
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormat.kyyyyMMdd_hhmm
            
            return formatter.string(from: date)
        }
        return ""
    }
    
    /// Convert String from Date format kyyyyMMdd_hhmmss to format kyyyyMMdd_Splash
    ///
    /// - Returns: Validated Date string
    func validDisplayDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.kyyyyMMdd_hhmmss
        if let date = dateFormatter.date(from: self) {
            let formatter = DateFormatter()
            formatter.dateFormat = DateFormat.kyyyyMMdd_Splash
            
            return formatter.string(from: date)
        }
        return ""
    }
    
    /// Convert Date string (kyyyyMMdd_hhmmss) to Date
    var toDate: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = DateFormat.kyyyyMMdd_hhmmss
        return dateFormatter.date(from: self)
    }
}
