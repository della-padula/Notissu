//
//  SchoolContract.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/19.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation

protocol SchoolView {
    func applyTableView(list: [Notice]) -> Void
}

protocol SchoolPresenterIf {
    func parseSchoolNotice(page: Int, keyword: String?)
}
