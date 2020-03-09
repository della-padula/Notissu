//
//  SearchPresenter.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/01/25.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation

class SearchPresenter: SearchPresenterProtocol {
    private var view: SearchViewProtocol
    private var model = SearchModel()
    
    init(view: SearchViewProtocol) {
        self.view = view
    }
    
    func getMajorListItem(at: Int) -> DeptName {
        return self.model.getMajorList()[at]
    }
    
    func getMajorCodeListItem(at: Int) -> DeptCode {
        return self.model.getMajorCodeList()[at]
    }
    
    func getMajorList() -> [DeptName] {
        return self.model.getMajorList()
    }
    
    func getMajorCodeList() -> [DeptCode] {
        return self.model.getMajorCodeList()
    }
    
    func getMajorListCount() -> Int {
        return self.model.getMajorList().count
    }
    
    func getMajorCodeListCount() -> Int {
        return self.model.getMajorCodeList().count
    }
}
