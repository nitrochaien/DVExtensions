//
//  Common.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 10/12/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

public class Common: NSObject {
    public static let sharedInstance = Common()
    
    /// Calculate Greatest Common Divisor
    ///
    /// - Parameter temp: array of integers
    /// - Returns: Greatest Common Divisor
    public func greatestCommonDivisor(_ temp: [Int]) -> Int {
        if var result = temp.first {
            for number in temp {
                result = greatestCommonDivisor(result, number)
            }
            return result
        }
        return 0
    }
    
    /// Calculate Least Common Multiplier
    ///
    /// - Parameter temp: array of integers
    /// - Returns: Least Common Multiplier
    public func leastCommonMuliplier(_ temp: [Int]) -> Int {
        if var result = temp.first {
            for number in temp {
                result = leastCommonMuliplier(result, number)
            }
            return result
        }
        return 0
    }
    
    /// Calculate Greatest Common Divisor between 2 numbers
    ///
    /// - Parameters:
    ///   - a: first number
    ///   - b: second number
    /// - Returns: Greatest Common Divisor
    private func greatestCommonDivisor(_ a: Int, _ b: Int) -> Int {
        let r = a % b
        if r != 0 {
            return greatestCommonDivisor(b, r)
        } else {
            return b
        }
    }
    
    /// Calculate Least Common Multiplier between 2 numbers
    ///
    /// - Parameters:
    ///   - a: first number
    ///   - b: second number
    /// - Returns: Least Common Multiplier
    private func leastCommonMuliplier(_ a: Int, _ b: Int) -> Int {
        return a / self.greatestCommonDivisor(a, b) * b
    }
    
    /// Convert 4-digits integer number to roman format
    ///
    /// - Parameter number: input number
    /// - Returns: roman number format
    func romanConverter(_ number: Int) -> String {
        var localNumber = number
        var result = ""
        
        let numberSymbols: [(number: Int, symbol: String)] =
            [(1000, "M"), (900, "CM"), (500, "D"), (400, "CD"), (100, "C"), (90, "XC"), (50, "L"), (40, "XL"), (10, "X"), (9, "IX"), (5, "V"), (4, "IV"), (1, "I")]
        
        for item in numberSymbols {
            while localNumber >= item.number {
                result += item.symbol
                localNumber = localNumber - item.number
            }
        }
        
        return result
    }
}
