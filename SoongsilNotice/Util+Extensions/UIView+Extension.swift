//
//  UIView+Extension.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/03/09.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public enum CornerDirection {
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    enum ViewSide: String {
        case Left = "Left", Right = "Right", Top = "Top", Bottom = "Bottom"
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.borderColor = color
        border.name = side.rawValue
        switch side {
        case .Left: border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .Right: border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        case .Top: border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .Bottom: border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        }
        
        border.borderWidth = thickness
        
        layer.addSublayer(border)
    }
    
    func removeBorder(toSide side: ViewSide) {
        guard let sublayers = self.layer.sublayers else { return }
        var layerForRemove: CALayer?
        for layer in sublayers {
            if layer.name == side.rawValue {
                layerForRemove = layer
            }
        }
        if let layer = layerForRemove {
            layer.removeFromSuperlayer()
        }
    }
}

