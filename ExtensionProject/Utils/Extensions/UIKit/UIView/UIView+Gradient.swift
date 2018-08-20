//
//  UIView+Gradient.swift
//  ExtensionProject
//
//  Created by Dinh Vu Nam on 8/20/18.
//  Copyright © 2018 Dinh Vu Nam. All rights reserved.
//

import UIKit

extension UIView {
    public enum UIViewGradientDirection {
        case vertical
        case horizontal
        case diagonalLeftTopToRightDown
        case diagonalLeftDownToRightTop
        case diagonalRightTopToLeftDown
        case diagonalRightDownToLeftTop
        case custom(startPoint: CGPoint, endPoint: CGPoint)
    }
    
    public func gradientCricleBorder(colors: [UIColor]){
        self.gradient(colors: colors, isCircle: true, direction: .horizontal)
    }
    
    public func gradient(colors: [UIColor]) {
        self.gradient(colors: colors, isCircle: false, direction: .horizontal)
    }
    
    @discardableResult
    public func gradient(colors: [UIColor], isCircle: Bool, direction: UIViewGradientDirection) -> CAGradientLayer {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        
        var mutableColors: [Any] = colors
        for index in 0 ..< colors.count {
            let currentColor: UIColor = colors[index]
            mutableColors[index] = currentColor.cgColor
        }
        gradient.colors = mutableColors
        
        switch direction {
        case .vertical:
            gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        case .horizontal:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .diagonalLeftTopToRightDown:
            gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        case .diagonalLeftDownToRightTop:
            gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        case .diagonalRightTopToLeftDown:
            gradient.startPoint = CGPoint(x: 1.0, y: 0.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 1.0)
        case .diagonalRightDownToLeftTop:
            gradient.startPoint = CGPoint(x: 1.0, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.0, y: 0.0)
        case .custom(let startPoint, let endPoint):
            gradient.startPoint = startPoint
            gradient.endPoint = endPoint
        }
        if isCircle == true {
            let shape = CAShapeLayer()
            shape.lineWidth = 5
            shape.path = UIBezierPath(arcCenter: CGPoint(x: self.frame.size.width / 2, y: self.frame.size.width / 2), radius: CGFloat(self.frame.size.width / 2), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true).cgPath
            shape.strokeColor = UIColor.black.cgColor
            shape.fillColor = UIColor.clear.cgColor
            gradient.mask = shape
            
        }
        self.layer.insertSublayer(gradient, at: 0)
        self.clipsToBounds = true
        return gradient
    }
    
    
    /// Animate Gradient with Custom color
    func addAnimateGradient() {
        let backgroundGray = UIColor(red: 246.0 / 255, green: 247 / 255, blue: 248 / 255, alpha: 1)
        let lightGray = UIColor(red: 238.0 / 255, green: 238 / 255, blue: 238 / 255, alpha: 1)
        let darkGray = UIColor(red: 221.0 / 255, green: 221 / 255, blue: 221 / 255, alpha: 1)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [
            backgroundGray.cgColor,
            lightGray.cgColor,
            darkGray.cgColor,
            lightGray.cgColor,
            backgroundGray.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: -0.85, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1.15, y: 0)
        gradientLayer.locations = [-0.85, -0.85, 0, 0.15, 1.15]
        
        //Add animation
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = gradientLayer.locations
        animation.toValue = [0, 1, 1, 1.05, 1.15]
        animation.repeatCount = .infinity
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.duration = 1
        gradientLayer.add(animation, forKey: "forever.loop")
        
        //Add Gradient
        self.layer.addSublayer(gradientLayer)
    }
}
