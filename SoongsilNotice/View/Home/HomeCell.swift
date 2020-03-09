//
//  HomeCell.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/07.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import UIKit

struct Major {
    var majorCode: DeptCode?
    var majorName: DeptName?
    var majorNameEng: DeptNameEng?
}

class HomeCell: UITableViewCell {
    @IBOutlet var majorTitle: UILabel!
    @IBOutlet var majorTitleEng: UILabel!
    private var majorCode: DeptCode?
    private var majorName: DeptName?
    
    var major: Major = Major() {
        didSet {
            majorTitle.text = major.majorName.map { $0.rawValue }
            majorTitleEng.text = major.majorNameEng.map { $0.rawValue }
            
            majorCode = major.majorCode
            majorName = major.majorName
        }
    }
}
