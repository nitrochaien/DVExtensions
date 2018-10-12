//
//  Int+Ext.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 10/12/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension Int {
    func greatestCommonDivisor(with number: Int) -> Int {
        let r = self % number
        if r != 0 {
            return number.greatestCommonDivisor(with: r)
        } else {
            return number
        }
    }
    
    func leastCommonMuliplier(with number: Int) -> Int {
        return number / self.greatestCommonDivisor(with: number) * number
    }
}
