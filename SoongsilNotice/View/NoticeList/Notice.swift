//
//  Notice.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/05.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation

class Notice: Codable {
    var author        : String?
    var title         : String?
    var url           : String?
    var date          : String?
    var writingUID    : String?
    var isNotice      : Bool?
    var hasAttachment : Bool?
    
    init(author: String, title: String, url: String, date: String, isNotice: Bool) {
        self.author        = author
        self.title         = title
        self.url           = url
        self.date          = date
        self.isNotice      = isNotice
        self.hasAttachment = false
    }
    
    init(author: String, title: String, url: String, date: String, isNotice: Bool, writingUID: String) {
        self.author        = author
        self.title         = title
        self.url           = url
        self.date          = date
        self.isNotice      = isNotice
        self.hasAttachment = false
        self.writingUID    = writingUID
    }
    
    init(author: String, title: String, url: String, date: String, isNotice: Bool, hasAttachment: Bool) {
        self.author        = author
        self.title         = title
        self.url           = url
        self.date          = date
        self.isNotice      = isNotice
        self.hasAttachment = hasAttachment
    }
}
