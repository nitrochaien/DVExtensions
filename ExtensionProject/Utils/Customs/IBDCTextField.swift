//
//  IBDCTextField.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 7/16/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

@IBDesignable open class IBDCTextField: TextFieldEffects {
    private let borderLayer = CALayer()
    private var textFieldInsets = CGPoint(x: 0, y: 0)
    let colorActive = UIColor.init(red: 208/255.0, green: 198/255.0, blue: 226/255.0, alpha: 1)
    let colorInActive = UIColor.init(red: 59/255.0, green: 63/255.0, blue: 194/255.0, alpha: 1)
    
    /* to change color boder
     by default get color setup in storyboard if forceColor is nil
     */
    var forceColorBorder:UIColor?
    
    /*
     default forceColorPlaceholder is nil
     by default get color setup in storyboad if forceColorPlaceholder is nil
     */
    var forceColorPlaceholder:UIColor?
    
    override open func drawViewsForRect(_ rect: CGRect) {
        updateBorder()
        updateBackground()
        updatePlaceHolder()
        layer.insertSublayer(borderLayer, at: 0)
    }
    
    private func updateBorder() {
        borderLayer.frame = rectForBounds(bounds)
        borderLayer.borderWidth = borderSize
        borderLayer.cornerRadius = _cornerRadius
        borderLayer.masksToBounds = true
        
        if forceColorBorder != nil {
            borderLayer.borderColor = forceColorBorder!.cgColor
        }else{
            borderLayer.borderColor = isFirstResponder ? activeBorderColor.cgColor : inactiveBorderColor.cgColor
        }
        
        if isFirstResponder {
            self.layer.masksToBounds = false
            self.layer.shadowRadius = _shadowRadius
            self.layer.shadowColor = shadowBackgroundColor.cgColor
            self.layer.shadowOffset = _shadowOffset
            self.layer.shadowOpacity = _shadowOpacity
        }else{
            self.layer.shadowColor = UIColor.clear.cgColor
            self.layer.shadowOffset = CGSize.init(width: 0.0, height: 0.0)
            self.layer.shadowOpacity = 0.0
        }
        
    }
    
    
    /// update text color placeholder, default get color from storyboard if forceColorPlaceholder is nil
    private func updatePlaceHolder() {
        if isDefault == true {
            self.attributedPlaceholder = NSAttributedString.init(string: self.placeholder ?? "", attributes:[NSAttributedStringKey.foregroundColor: colorInActive])
            return
        }
        
        if forceColorPlaceholder != nil {
            self.attributedPlaceholder = NSAttributedString.init(string: self.placeholder ?? "", attributes:[NSAttributedStringKey.foregroundColor: forceColorPlaceholder!])
        }else{
            let color = isFirstResponder ? colorActive : colorInActive
            self.attributedPlaceholder = NSAttributedString.init(string: self.placeholder ?? "", attributes:[NSAttributedStringKey.foregroundColor: color])
        }
    }
    
    private func rectForBounds(_ bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x, y: bounds.origin.y, width: bounds.size.width, height: bounds.size.height)
    }
    
    /*
     force change color border
     */
    func setBolderColor(color:UIColor?) {
        forceColorBorder = color
        updateBorder()
    }
    
    // change background layer
    func setBackgroundLayer(_ color:UIColor) {
        borderLayer.backgroundColor = color.cgColor
    }
    
    /*
     force change color placeholder
     */
    func setColorPlaceHolder(color:UIColor?) {
        forceColorPlaceholder = color
        updatePlaceHolder()
    }
    //MARK:- IBInspectable
    
    @IBInspectable open var isDefault: Bool = false {
        didSet {
            updatePlaceHolder()
        }
    }
    
    @IBInspectable open var placeHolderFontActive: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            updatePlaceHolder()
        }
    }
    
    @IBInspectable open var placeHolderFontInActive: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            updatePlaceHolder()
        }
    }
    
    @IBInspectable open var borderSize: CGFloat = 2.0 {
        didSet {
            updateBorder()
        }
    }
    
    @IBInspectable open var _cornerRadius: CGFloat = 0.0 {
        didSet {
            updateBorder()
        }
    }
    
    @IBInspectable dynamic open var textFieldInset: CGPoint = .zero {
        didSet {
            textFieldInsets = textFieldInset
        }
    }
    
    @IBInspectable dynamic open var activeBorderColor: UIColor = .clear {
        didSet {
            updateBorder()
        }
    }
    
    @IBInspectable dynamic open var inactiveBorderColor: UIColor = .clear {
        didSet {
            updateBorder()
        }
    }
    
    @IBInspectable dynamic open var activeBackgroundColor: UIColor = .clear {
        didSet {
            updateBackground()
        }
    }
    
    @IBInspectable dynamic open var inactiveBackgroundColor: UIColor = .clear {
        didSet {
            updateBackground()
        }
    }
    
    @IBInspectable dynamic open var shadowBackgroundColor: UIColor = .clear {
        didSet {
            updateBorder()
            updateBackground()
        }
    }
    
    @IBInspectable dynamic open var _shadowOpacity: Float = 0.0 {
        didSet {
            updateBorder()
            updateBackground()
        }
    }
    
    @IBInspectable dynamic open var _shadowOffset: CGSize = .zero {
        didSet {
            updateBorder()
            updateBackground()
        }
    }
    
    @IBInspectable dynamic open var _shadowRadius: CGFloat = 0.0 {
        didSet {
            updateBorder()
            updateBackground()
        }
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.offsetBy(dx: textFieldInsets.x, dy: textFieldInsets.y)
    }
    
    private func updateBackground() {
        if isDefault == true {
            borderLayer.backgroundColor = inactiveBackgroundColor.cgColor
            return
        }
        if let text = text {
            if isFirstResponder || !text.isEmpty {
                borderLayer.backgroundColor = activeBackgroundColor.cgColor
            } else {
                borderLayer.backgroundColor = inactiveBackgroundColor.cgColor
            }
        }
    }
    
    // MARK: - Overrides
    override open var bounds: CGRect {
        didSet {
            updateBorder()
            updateBackground()
        }
    }
    
    private func animateViews() {
        UIView.animate(withDuration: 0.2, animations: {
            // Prevents a "flash" in the placeholder
            if self.text!.isEmpty {
                
            }
        }) { _ in
            UIView.animate(withDuration: 0.3, animations: {
                self.updateBorder()
                self.updatePlaceHolder()
                self.updateBackground()
            }, completion: { _ in
                self.animationCompletionHandler?(self.isFirstResponder ? .textEntry : .textDisplay)
            })
        }
    }
    
    // MARK: - TextFieldEffects
    
    override open func animateViewsForTextEntry() {
        animateViews()
    }
    
    override open func animateViewsForTextDisplay() {
        animateViews()
    }
}
