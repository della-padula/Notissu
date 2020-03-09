//
//  RoundButton.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/03/09.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import UIKit

class RoundButton: UIButton {

    required init(coder: NSCoder) {
        super.init(coder: coder)!
        
        self.clipsToBounds = true
        self.layer.cornerRadius = 5
        self.titleLabel?.font = .AppleSDSemiBold17P
        
        self.adjustsImageWhenHighlighted = false
        
        self.setBackgroundColor(.MONO300, for: .disabled)
        self.setBackgroundColor(.MAIN100, for: .normal)
        self.setBackgroundColor(.MAIN200, for: .highlighted)
        
        self.setTitleColor(.MONO0, for: .normal)
        self.setTitleColor(.MONO0, for: .disabled)
        self.setTitleColor(.MONO0, for: .highlighted)
    }
    
}

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
         
        self.setBackgroundImage(backgroundImage, for: state)
    }
}
