//
//  MyNoticeDeptSelectCell.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/03/09.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import UIKit

class MyNoticeDeptSelectCell: UICollectionViewCell {
    
    @IBOutlet weak var majorImageView: UIImageView!
    @IBOutlet weak var lblMajorName: UILabel!
    @IBOutlet weak var lblMajorEngName: UILabel!
    
    @IBOutlet var widthConstraint: NSLayoutConstraint!
    
    var width: CGFloat = 0.0 {
        didSet {
            self.contentView.frame.size = CGSize(width: width, height: width)
            self.widthConstraint.constant = width
            
            print("[a]...contentView frame width: \(self.contentView.frame.width)")
            
            print("[a]...widthConstraint.constant: \(self.widthConstraint.constant)")
        }
    }
    
    var major: Major = Major() {
        didSet {
            self.lblMajorName.text = major.majorName.map { $0.rawValue }
            self.lblMajorEngName.text = major.majorNameEng.map { $0.rawValue }
            
            print("[CELL] contentView width : \(self.contentView.frame.width)")
            print("[CELL] contentView height : \(self.contentView.frame.height)")
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                self.majorImageView.tintColor = .MAIN200
                self.lblMajorName.textColor = .MAIN200
                self.lblMajorEngName.textColor = .MAIN200
            } else {
                self.majorImageView.tintColor = .MONO400
                self.lblMajorName.textColor = .MONO400
                self.lblMajorEngName.textColor = .MONO400
            }
        }
    }
}
