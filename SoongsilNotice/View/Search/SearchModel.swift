//
//  SearchModel.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/01/25.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation

class SearchModel: SearchModelProtocol {
    private var majorList = [DeptName]()
    private var majorCodeList = [DeptCode]()
    
    init() {
        for deptName in DeptName.allCases {
            if deptName != DeptName.Inmun_Writing {
                majorList.append(deptName)
            }
        }
        
        for deptCode in DeptCode.allCases {
            if deptCode != DeptCode.Inmun_Writing {
                majorCodeList.append(deptCode)
            }
        }
    }
    
    func getMajorList() -> [DeptName] {
        return self.majorList
    }
    
    func getMajorCodeList() -> [DeptCode] {
        return self.majorCodeList
    }
}
