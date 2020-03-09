//
//  NoticeListViewCell.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/05.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import UIKit

class NoticeListViewCell: UITableViewCell {

    @IBOutlet var attachmentWidthConstraint: NSLayoutConstraint!
    @IBOutlet var attachmentSymbol: UIView!
    @IBOutlet var noticeBadge     : UILabel!
    @IBOutlet var noticeTitle     : UILabel!
    @IBOutlet var noticeDate      : UILabel!
    @IBOutlet var noticeBadgeWidthConstraint: NSLayoutConstraint!
    
    var deptName: DeptName?
    var isBookmark: Bool = false
    
    var notice  : Notice? {
        didSet {
            self.applyDataToView()
        }
    }
    
    private func applyDataToView() {
        self.noticeTitle.text = notice?.title
        
        guard let strongNotice = notice else {
            return
        }
        
        self.attachmentWidthConstraint.constant = (strongNotice.hasAttachment ?? false) ? 50 : 0
        
        if isBookmark {
            self.noticeDate.text = "\(strongNotice.date ?? "") | \(deptName?.rawValue ?? "")"
        } else {
            self.noticeDate.text = strongNotice.date ?? ""
        }
        
        if !isBookmark {
            self.noticeBadge.text = "공지"
            self.noticeBadge.isHidden = !(strongNotice.isNotice ?? false)
        }
        
        if !isBookmark && strongNotice.isNotice ?? false {
            noticeBadgeWidthConstraint.constant = 36
        } else {
            noticeBadgeWidthConstraint.constant = 0
        }
    }
}
