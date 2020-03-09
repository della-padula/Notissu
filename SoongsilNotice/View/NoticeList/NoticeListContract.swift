//
//  NoticeListContract.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/05.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import UIKit

protocol NoticeListView {
    func applyToTableView(list: [Notice])
}

protocol NoticePresenter {
    func loadNoticeList(page: Int, keyword: String?, deptCode: DeptCode)
    
    func fetchFavoriteNoticeList()
}
