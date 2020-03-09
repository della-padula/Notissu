//
//  SchoolPresenter.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/19.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

class SchoolPresenter : SchoolPresenterIf {
    private var view: SchoolView?
    
    init(view: SchoolView) {
        self.view = view
    }
    
    func parseSchoolNotice(page: Int, keyword: String?) {
        NoticeSoongsil.parseSchoolNotice(page: page, keyword: keyword, completion: self.view!.applyTableView)
    }
}
