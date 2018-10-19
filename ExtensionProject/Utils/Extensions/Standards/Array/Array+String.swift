//
//  Array+String.swift
//  ExtensionProject
//
//  Created by Nam Vu on 10/19/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension Array where Element == String {
    func concatenate() -> String {
        return self.reduce("", { $0 + $1 + " "})
    }
}
