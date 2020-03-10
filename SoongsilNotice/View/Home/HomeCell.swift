//
//  HomeCell.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/07.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {
    @IBOutlet weak var majorTitle: UILabel!
    @IBOutlet weak var majorTitleEng: UILabel!
    @IBOutlet weak var itemBgView: UIView!
    @IBOutlet weak var majorImageView: UIImageView!
    
    private var majorCode: DeptCode?
    private var majorName: DeptName?
    
    var major: Major = Major() {
        didSet {
            let majorNameText = major.majorName.map { $0.rawValue }
            self.majorTitle.text = majorNameText?.replacingOccurrences(of: " ", with: "")
            self.majorTitleEng.text = major.majorNameEng.map { $0.rawValue }
            
            majorCode = major.majorCode
            majorName = major.majorName
            
            self.majorTitle.font    = .AppleSDSemiBold17P
            self.majorTitle.textColor = .MONO500
            self.majorTitleEng.font = .SFProTextRegular11P
            self.majorTitleEng.textColor = .MONO500
            
            self.itemBgView.clipsToBounds      = true
            self.itemBgView.layer.cornerRadius = 8
            self.itemBgView.backgroundColor    = .SUB100
            self.majorImageView.tintColor      = .MONO500
        }
    }
}
