//
//  MajorModel.swift
//  SoongsilNotice
//
//  Created by denny.k on 22/02/2020.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation

public struct Major {
    var majorCode: DeptCode?
    var majorName: DeptName?
    var majorNameEng: DeptNameEng?
}

public struct MajorModel {
    // 학교 부대 시설
    static var majorCodeListSoongsil    = [DeptCode.Dormitory]
    static var majorNameListSoongsil    = [DeptName.Dormitory]
    static var majorEngNameListSoongsil = [DeptNameEng.Dormitory]
    
    // IT대학
    static var majorCodeListIT = [DeptCode.IT_Computer, DeptCode.IT_Media, DeptCode.IT_Electric, DeptCode.IT_Software, DeptCode.IT_SmartSystem]
    static var majorNameListIT = [DeptName.IT_Computer, DeptName.IT_Media, DeptName.IT_Electric, DeptName.IT_Software, DeptName.IT_SmartSystem]
    static var majorEngNameListIT = [DeptNameEng.IT_Computer, DeptNameEng.IT_Media, DeptNameEng.IT_Electric, DeptNameEng.IT_Software, DeptNameEng.IT_SmartSystem]
    
    // 법과대학
    static var majorCodeListLaw = [DeptCode.LAW_Law, DeptCode.LAW_IntlLaw]
    static var majorNameListLaw = [DeptName.LAW_Law, DeptName.LAW_IntlLaw]
    static var majorEngNameListLaw = [DeptNameEng.LAW_Law, DeptNameEng.LAW_IntlLaw]
    
    // 인문대학
    static var majorCodeListInmun = [DeptCode.Inmun_Korean, DeptCode.Inmun_French, DeptCode.Inmun_German, DeptCode.Inmun_Chinese, DeptCode.Inmun_English, DeptCode.Inmun_History, DeptCode.Inmun_Philosophy, DeptCode.Inmun_Japanese, DeptCode.Inmun_Writing]
//    , DeptCode.Inmun_Film
    static var majorNameListInmun = [DeptName.Inmun_Korean, DeptName.Inmun_French, DeptName.Inmun_German, DeptName.Inmun_Chinese, DeptName.Inmun_English, DeptName.Inmun_History, DeptName.Inmun_Philosophy, DeptName.Inmun_Japanese, DeptName.Inmun_Writing]
//    , DeptName.Inmun_Film
    static var majorEngNameListInmun = [DeptNameEng.Inmun_Korean, DeptNameEng.Inmun_French, DeptNameEng.Inmun_German, DeptNameEng.Inmun_Chinese, DeptNameEng.Inmun_English, DeptNameEng.Inmun_History, DeptNameEng.Inmun_Philosophy, DeptNameEng.Inmun_Japanese, DeptNameEng.Inmun_Writing]
//    , DeptNameEng.Inmun_Film
    
    // 공과대학
    static var majorCodeListEngineer = [DeptCode.Engineering_Chemistry, DeptCode.Engineering_Machine, DeptCode.Engineering_Electonic, DeptCode.Engineering_Industrial, DeptCode.Engineering_Organic, DeptCode.Engineering_Architect]
    static var majorNameListEngineer = [DeptName.Engineering_Chemistry, DeptName.Engineering_Machine, DeptName.Engineering_Electonic, DeptName.Engineering_Industrial, DeptName.Engineering_Organic, DeptName.Engineering_Architect]
    static var majorEngNameListEngineer = [DeptNameEng.Engineering_Chemistry, DeptNameEng.Engineering_Machine, DeptNameEng.Engineering_Electonic, DeptNameEng.Engineering_Industrial, DeptNameEng.Engineering_Organic, DeptNameEng.Engineering_Architect]
    
    // 자연과학대학
    static var majorCodeListNaturalScience = [DeptCode.NaturalScience_Math, DeptCode.NaturalScience_Physics, DeptCode.NaturalScience_Chemistry, DeptCode.NaturalScience_Actuarial, DeptCode.NaturalScience_Medical]
    static var majorNameListNaturalScience = [DeptName.NaturalScience_Math, DeptName.NaturalScience_Physics, DeptName.NaturalScience_Chemistry, DeptName.NaturalScience_Actuarial, DeptName.NaturalScience_Medical]
    static var majorEngNameListNaturalScience = [DeptNameEng.NaturalScience_Math, DeptNameEng.NaturalScience_Physics, DeptNameEng.NaturalScience_Chemistry, DeptNameEng.NaturalScience_Actuarial, DeptNameEng.NaturalScience_Medical]
    
    // 경영대학 4
    static var majorCodeListBusiness = [DeptCode.Business_biz, DeptCode.Business_venture, DeptCode.Business_Account, DeptCode.Business_Finance]
    static var majorNameListBusiness = [DeptName.Business_biz, DeptName.Business_venture, DeptName.Business_Account, DeptName.Business_Finance]
    static var majorEngNameListBusiness = [DeptNameEng.Business_biz, DeptNameEng.Business_venture, DeptNameEng.Business_Account, DeptNameEng.Business_Finance]
    
    // 경제통상대학 2
    static var majorCodeListEconomy = [DeptCode.Economy_Economics, DeptCode.Economy_GlobalCommerce]
    static var majorNameListEconomy = [DeptName.Economy_Economics, DeptName.Economy_GlobalCommerce]
    static var majorEngNameListEconomy = [DeptNameEng.Economy_Economics, DeptNameEng.Economy_GlobalCommerce]
    
    // 사회과학대학 6
    static var majorCodeListSocial = [DeptCode.Social_Welfare, DeptCode.Social_Administration, DeptCode.Social_Sociology, DeptCode.Social_Journalism, DeptCode.Social_LifeLong, DeptCode.Social_Political]
    static var majorNameListSocial = [DeptName.Social_Welfare, DeptName.Social_Administration, DeptName.Social_Sociology, DeptName.Social_Journalism, DeptName.Social_LifeLong, DeptName.Social_Political]
    static var majorEngNameListSocial = [DeptNameEng.Social_Welfare, DeptNameEng.Social_Administration, DeptNameEng.Social_Sociology, DeptNameEng.Social_Journalism, DeptNameEng.Social_LifeLong, DeptNameEng.Social_Political]
    
    static var majorConvergence = Major(majorCode: DeptCode.MIX_mix, majorName: DeptName.MIX_mix, majorNameEng: DeptNameEng.MIX_mix)
    
    static var majorListSoongsil = [Major]()
    static var majorListIT       = [Major]()
    static var majorListLaw      = [Major]()
    static var majorListInmun    = [Major]()
    static var majorListEngineer = [Major]()
    static var majorListNatural  = [Major]()
    static var majorListBusiness = [Major]()
    static var majorListEconomy  = [Major]()
    static var majorListSocial   = [Major]()
    
    static func initializeMajor() {
        for index in 0..<majorCodeListSoongsil.count {
            majorListSoongsil.append(Major(majorCode: majorCodeListSoongsil[index], majorName: majorNameListSoongsil[index], majorNameEng: majorEngNameListSoongsil[index]))
        }
        
        for index in 0..<majorCodeListIT.count {
            majorListIT.append(Major(majorCode: majorCodeListIT[index], majorName: majorNameListIT[index], majorNameEng: majorEngNameListIT[index]))
        }
        
        for index in 0..<majorCodeListLaw.count {
            majorListLaw.append(Major(majorCode: majorCodeListLaw[index], majorName: majorNameListLaw[index], majorNameEng: majorEngNameListLaw[index]))
        }
        
        for index in 0..<majorCodeListInmun.count {
            majorListInmun.append(Major(majorCode: majorCodeListInmun[index], majorName: majorNameListInmun[index], majorNameEng: majorEngNameListInmun[index]))
        }
        
        for index in 0..<majorCodeListEngineer.count {
            majorListEngineer.append(Major(majorCode: majorCodeListEngineer[index], majorName: majorNameListEngineer[index], majorNameEng: majorEngNameListEngineer[index]))
        }
        
        for index in 0..<majorCodeListNaturalScience.count {
            majorListNatural.append(Major(majorCode: majorCodeListNaturalScience[index], majorName: majorNameListNaturalScience[index], majorNameEng: majorEngNameListNaturalScience[index]))
        }
        
        for index in 0..<majorCodeListBusiness.count {
            majorListBusiness.append(Major(majorCode: majorCodeListBusiness[index], majorName: majorNameListBusiness[index], majorNameEng: majorEngNameListBusiness[index]))
        }
        
        for index in 0..<majorCodeListEconomy.count {
            majorListEconomy.append(Major(majorCode: majorCodeListEconomy[index], majorName: majorNameListEconomy[index], majorNameEng: majorEngNameListEconomy[index]))
        }
        
        for index in 0..<majorCodeListSocial.count {
            majorListSocial.append(Major(majorCode: majorCodeListSocial[index], majorName: majorNameListSocial[index], majorNameEng: majorEngNameListSocial[index]))
        }
    }
}
