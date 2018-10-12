//
//  Int+Ext.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension Int {
    /// Convert price to short character
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10) mio"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)K"
        }
        else {
            return "\(Int(number))"
        }
    }
    
    /// Round converted price to specific occurrences
    ///
    /// - Parameter occurrences: replacing occurrences
    /// - Returns: Rounded price
    func roundedPrice(with occurrences: String = ".0") -> String {
        return "\(self.roundedWithAbbreviations.replacingOccurrences(of: occurrences, with: ""))"
    }
    
    /// Convert seconds to tuple of hours, minutes, seconds
    ///
    /// - Returns: Tuple of hours, minutes, seconds
    func secondsToHoursMinutesSeconds () -> (Int, Int, Int) {
        let seconds = self
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
}
