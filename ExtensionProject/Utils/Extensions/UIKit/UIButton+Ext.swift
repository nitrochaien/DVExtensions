//
//  UIButton+Ext.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 8/20/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension UIButton {
    class func initWithImageTitleColor(name: String, title: String = "", colorText: UIColor = UIColor.white, font: UIFont = UIFont.systemFont(ofSize: 14), frame: CGRect, target: Any, action: Selector) -> UIButton {
        let button = UIButton.init(type: .custom)
        button.frame = frame
        let image = UIImage.init(named: name)
        button.setImage(image, for: .normal)
        if !title.isEmpty {
            button.setTitle(title, for: .normal)
            button.setTitleColor(colorText, for: .normal)
            button.titleEdgeInsets = UIEdgeInsetsMake(0, 18, 0, 0)
        }
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
}
