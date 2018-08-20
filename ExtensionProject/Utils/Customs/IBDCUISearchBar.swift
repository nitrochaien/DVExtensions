//
//  IBDCUISearchBar.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

@IBDesignable open class IBDCUISearchBar: UISearchBar {
    var fontPlaceHolderColor = UIFont.systemFont(ofSize: 14)
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        updateSearch()
    }
    
    @IBInspectable open var setIconSearchColor: UIColor = UIColor.gray {
        didSet {
            updateSearch()
        }
    }
    
    @IBInspectable open var setPlaceHolderColor: UIColor = UIColor.gray {
        didSet {
            updateSearch()
        }
    }
    
    @IBInspectable open var setBackGroundColor: UIColor = UIColor.gray {
        didSet {
            updateSearch()
        }
    }
    
    @IBInspectable open var setTextColor: UIColor = UIColor.gray {
        didSet {
            updateSearch()
        }
    }
    
    @IBInspectable open var setBorderColor: UIColor = UIColor.gray {
        didSet {
            updateSearch()
        }
    }
    
    @IBInspectable open var setBorderWidth: CGFloat = 0.0 {
        didSet {
            updateSearch()
        }
    }
    
    @IBInspectable open var setRadius: CGFloat = 0.0 {
        didSet {
            updateSearch()
        }
    }
    
    /// change font of placeholder
    ///
    /// - Parameter font: default system font size 14
    func updateFontPlaceHolder(font:UIFont = UIFont.systemFont(ofSize: 14))  {
        self.fontPlaceHolderColor = font
        updateSearch()
    }
    
    private func updateSearch() {
        for view in self.subviews.last!.subviews {
            if type(of: view) == NSClassFromString("UISearchBarBackground"){
                view.alpha = 0.0
            }
        }
        if let textfield = self.value(forKey: "searchField") as? UITextField {
            textfield.textColor = setTextColor
            textfield.backgroundColor = setBackGroundColor
            textfield.attributedPlaceholder = NSAttributedString.init(string: textfield.placeholder ?? "",
                                                                      attributes: [NSAttributedStringKey.foregroundColor: setPlaceHolderColor,
                                                                                   NSAttributedStringKey.font:fontPlaceHolderColor])
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = setIconSearchColor
            }
            
            if let backgroundview = textfield.subviews.first {
                // Rounded corner
                backgroundview.layer.cornerRadius = setRadius
                backgroundview.layer.borderColor = setBorderColor.cgColor
                backgroundview.layer.borderWidth = setBorderWidth
                backgroundview.clipsToBounds = true
            }
        }
    }
}
