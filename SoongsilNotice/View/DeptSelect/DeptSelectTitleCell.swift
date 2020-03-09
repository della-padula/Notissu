//
//  DeptSelectTitleCell.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/03/09.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import UIKit

class DeptSelectTitleCell: UICollectionViewCell {
    @IBOutlet weak var lblSectionTitle: UILabel!
    @IBOutlet var selectedBar: UIView!
    
    var sectionName: String {
        didSet {
            self.alpha = 0.3
            lblSectionTitle.text = sectionName;
            lblSectionTitle.font = .AppleSDBold14P
            lblSectionTitle.textColor = .MONO500
        }
    }
    
    override var isSelected: Bool {
        didSet {
            print("isSelected : \(isSelected)")
//            self.isOpaque = true
            self.lblSectionTitle.alpha = isSelected ? 1.0 : 0.3
            
            self.selectedBar.isHidden = !isSelected
            self.selectedBar.clipsToBounds      = true
            self.selectedBar.layer.cornerRadius = 2
            self.selectedBar.backgroundColor    = .MAIN100
        }
    }


    required init?(coder aDecoder: NSCoder) {
        self.sectionName = ""
        super.init(coder: aDecoder)
    }
}
