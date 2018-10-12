//
//  Double+Ext.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 10/10/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension Double {
    func round(toFraction digits: Int) -> String { // changed input type of data
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = digits // for float
        formatter.maximumFractionDigits = digits // for float
        formatter.minimumIntegerDigits = 1
        formatter.paddingPosition = .afterPrefix
        formatter.paddingCharacter = "0"
        return formatter.string(from: NSNumber(floatLiteral: self))! // here double() is not required as data is already double
    }
}
