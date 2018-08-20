//
//  String+Ext.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension String {
    /// Change color of selected text in string
    ///
    /// - Parameters:
    ///   - coloredText: text to color
    ///   - color: desired color
    /// - Returns: String with colored text
    func changeColor(coloredText: String, with color: UIColor) -> NSAttributedString {
        let strNumber: NSString = self as NSString
        let range = strNumber.range(of: coloredText)
        let attribute = NSMutableAttributedString(string: self)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: color , range: range)
        
        return attribute
    }
    
    /// Get width height of String
    ///
    /// - Parameter font: current font
    /// - Returns: Size of String
    func getSize(using font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedStringKey.font: font]
        return self.size(withAttributes: fontAttributes)
    }
    
    /// Check if input string is in valid email format
    ///
    /// - Returns: true if input string is in valid email format, false otherwise
    func isValidEmail() -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailMat = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailMat.evaluate(with: self)
    }
    
    /// Get document path
    ///
    /// - Returns: document path in String format
    func getDocumentPath() -> String {
        let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        return documentDirectory.appending("/")
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get {
            return self[..<index(startIndex, offsetBy: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        get {
            return self[...index(startIndex, offsetBy: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        get {
            return self[index(startIndex, offsetBy: value.lowerBound)...]
        }
    }
}
