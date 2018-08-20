//
//  UIAlertController+Ext.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 8/20/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension UIAlertController {
    func setCustomTitle(_ attributeString: NSAttributedString) {
        setValue(attributeString, forKey: "attributedTitle")
    }
    
    func setCustomMessage(_ attributeString: NSAttributedString) {
        setValue(attributeString, forKey: "attributedMessage")
    }
    
    func setContentViewController(_ controller: UIViewController, _ height: CGFloat? = nil) {
        setValue(controller, forKey: "contentViewController")
        if let height = height {
            controller.preferredContentSize.height = height
            preferredContentSize.height = height
        }
    }
    
    func setBackgroundColor(_ color: UIColor) {
        if let backgroundView = view.subviews.last?.subviews.last {
            backgroundView.layer.cornerRadius = 14.0
            backgroundView.backgroundColor = color
        }
    }
}

extension UIAlertAction {
    func setTextColor(_ color: UIColor) {
        setValue(color, forKey: "titleTextColor")
    }
}
