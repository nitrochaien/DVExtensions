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
    
    public func greatestCommonDivisor(_ temp: [Int]) -> Int {
        if var result = temp.first {
            for number in temp {
                result = greatestCommonDivisor(result, number)
            }
            return result
        }
        return 0
    }
    
    public func leastCommonMuliplier(_ temp: [Int]) -> Int {
        if var result = temp.first {
            for number in temp {
                result = leastCommonMuliplier(result, number)
            }
            return result
        }
        return 0
    }
    
    private func greatestCommonDivisor(_ a: Int, _ b: Int) -> Int {
        let r = a % b
        if r != 0 {
            return greatestCommonDivisor(b, r)
        } else {
            return b
        }
    }
    
    private func leastCommonMuliplier(_ a: Int, _ b: Int) -> Int {
        return a / self.greatestCommonDivisor(a, b) * b
    }
}
