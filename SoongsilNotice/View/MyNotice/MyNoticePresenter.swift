//
//  MyNoticePresenter.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/03/09.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation

class MyNoticePresenter: MyNoticePresenterProtocol {
    private var view: MyNoticeViewProtocol!
    
    init(view: MyNoticeViewProtocol) {
        self.view = view
    }
}
