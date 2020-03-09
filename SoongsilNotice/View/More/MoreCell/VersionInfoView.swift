//
//  VersionInfoCell.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/02/26.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation
import UIKit

struct Version {
    let currentVersion: String
    let recentVersion: String
    let isUpdateRequired: Bool
}

class VersionInfoView: UIView {
    @IBOutlet var lblCurrentVersion: UILabel!
    @IBOutlet var lblRecentVersion : UILabel!
    @IBOutlet var lblStateMessage  : UILabel!
    @IBOutlet var updateBtn: UIButton!
    
    @IBAction func onClickUpdate(_ sender: Any) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id1488050194"),
            UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    var version: Version? {
        didSet {
            self.applyVersionToView()
        }
    }
    
    class func viewFromNib() -> Self {
        guard let view = Bundle.main.loadNibNamed(String(describing: Self.self), owner: nil, options: nil)?[0] as? Self else {
            fatalError("\(String(describing: Self.self)) viewFromNib fail")
        }
        return view
    }
    
    private func applyVersionToView() {
        if let ver = self.version {
            self.updateBtn.layer.borderColor = UIColor(named: "notissuAccent1000s")?.cgColor
            self.updateBtn.layer.borderWidth = 1
            
            self.updateBtn.layer.masksToBounds = true
            self.updateBtn.layer.cornerRadius = 6
            
            self.lblCurrentVersion.text = "현재 버전 : \(ver.currentVersion)"
            self.lblRecentVersion.text = "최신 버전 : \(ver.recentVersion)"
            
            self.updateBtn.isHidden = !ver.isUpdateRequired
            
            if ver.isUpdateRequired {
                self.lblStateMessage.text = "업데이트가 필요합니다."
                self.lblStateMessage.textColor = UIColor(named: "notissuRed1000s")
            } else {
                self.lblStateMessage.text = "최신 버전을 사용중입니다."
                self.lblStateMessage.textColor = UIColor(named: "notissuGray500s")
            }
        }
    }
}
