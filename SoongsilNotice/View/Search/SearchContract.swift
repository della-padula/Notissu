//
//  SearchContract.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/01/25.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation

protocol SearchViewProtocol {
    
}

protocol SearchPresenterProtocol {
    func getMajorCodeListItem(at: Int) -> DeptCode
    
    func getMajorListItem(at: Int) -> DeptName
    
    func getMajorCodeList() -> [DeptCode]
    
    func getMajorList() -> [DeptName]
    
    func getMajorCodeListCount() -> Int
    
    func getMajorListCount() -> Int
}

protocol SearchModelProtocol {
    func getMajorCodeList() -> [DeptCode]
    
    func getMajorList() -> [DeptName]
}
