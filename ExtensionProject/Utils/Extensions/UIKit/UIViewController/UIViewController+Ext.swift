//
//  UIViewController+Ext.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 8/20/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Hide Keyboard when tap anywhere in view
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    /// Selector for hideKeyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    /// Screen Shot UIViewController
    ///
    /// - Returns: Screenshot Image
    func screenshot() -> UIImage {
        //Create the UIImage
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    /// Show auto dismiss alert
    ///
    /// - Parameter message: String
    func showAutoDismissAlert(message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        let dismissTime = DispatchTime.now() + 2.0
        DispatchQueue.main.asyncAfter(deadline: dismissTime) {
            alert.dismiss(animated: true, completion: nil)
        }
    }
}
