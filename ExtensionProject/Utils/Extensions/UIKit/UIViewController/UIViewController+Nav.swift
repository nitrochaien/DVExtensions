//
//  UIViewController + Ext.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 8/20/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension UIViewController {
    func initBackView(title: String, _ tintColor: UIColor? = nil, _ font: UIFont,  _ selector: Selector? = nil) {
        var widthLeftButton = 100
        if let image = UIImage(named: "ic_back") {
            widthLeftButton = Int(image.size.width + title.getSize(using: font).width) + 35
        }
        
        let color = tintColor ?? #colorLiteral(red: 0.2310000062, green: 0.2469999939, blue: 0.7609999776, alpha: 1)
        var icon = "ic_back"
        if color == .white {
            icon = "ic_back_white"
        }
        
        leftBarButtonItem(imageName: icon, title: title, frame: CGRect(x: 0, y: 0, width: widthLeftButton, height: 30), colorText: color, font: font, target: self, action: selector ?? #selector(popToViewController))
    }
    
    func leftBarButtonItem(imageName: String, title: String, frame: CGRect, colorText: UIColor, font: UIFont, target: Any, action: Selector) {
        let leftBt = UIButton.initWithImageTitleColor(name: imageName, title: title, colorText: colorText, font: font, frame: frame, target: target, action: action)
        leftBt.transform = CGAffineTransform(translationX: 0, y: 0)
        
        // add the button to a container, otherwise the transform will be ignored
        let suggestButtonContainer = UIView(frame: leftBt.frame)
        suggestButtonContainer.addSubview(leftBt)
        let suggestButtonItem = UIBarButtonItem(customView: suggestButtonContainer)
        
        self.navigationItem.leftBarButtonItem = suggestButtonItem
    }
    
    @objc func popToViewController() {
        navigationController?.popViewController(animated: true)
    }
}
