//
//  Array+Element.swift
//  ExtensionProject
//
//  Created by Nam Vu on 10/19/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension Array where Element: Numeric {
    func sum() -> Element {
        return self.reduce(0, { $0 + $1 })
    }
}
