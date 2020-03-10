//
//  NoticeURL.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/08.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation
import Alamofire

struct NoticeRequestURL {
    // IT College
    static func IT_computer(page: Int, keyword: String?) -> String {
        return "http://cse.ssu.ac.kr/03_sub/01_sub.htm?page=\(page)&key=\(keyword ?? "")&keyfield=subject&category=&bbs_code=Ti_BBS_1"
    }
    
    static func IT_media(page: Int, keyword: String?) -> String {
        return "http://media.ssu.ac.kr/sub.php?code=XxH00AXY&mode=&category=1&searchType=title&search=\(keyword ?? "")&orderType=&orderBy=&page=\(page)"
    }
    
    static func IT_electric(page: Int, keyword: String?) -> String {
        return "http://infocom.ssu.ac.kr/rb/?c=2/38&where=subject%7Ctag&keyword=\(keyword ?? "")&p=\(page)"
    }
    
    static func IT_smartsw(page: Int, keyword: String?) -> String {
        return "http://smartsw.ssu.ac.kr/board/notice/\(page)?search=\(keyword ?? "")"
    }
    
    static func IT_software(page: Int, keyword: String?) -> String {
        return "https://sw.ssu.ac.kr/bbs/board.php?bo_table=sub6_1&sca=&stx=\(keyword ?? "")&sop=and&page=\(page)"
    }
    
    // Soongsil Notice
    static func SSU_Catch(page: Int, keyword: String?) -> String {
        return "https://scatch.ssu.ac.kr/%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD/page/\(page)/?f=all&keyword=\(keyword ?? "")"
    }
    
    static func SSU_Dormitory(page: Int, keyword: String?) -> String {
        let offset = (page < 1 ? 0 : (page - 1)) * 15
        return "https://ssudorm.ssu.ac.kr:444/SShostel/mall_main.php?viewform=B0001_noticeboard_list&formpath=&board_type=&next=\(offset)&board_no=1&Q=&W=title&Q=\(EuckrUtil.euckrEncoding(keyword) ?? "")"
    }
    
    // 경영대학
    static func businessBiz(page: Int, keyword: String?) -> String {
        return "http://biz.ssu.ac.kr/bbs/list.do?&bId=BBS_03_NOTICE&sc_title=\(keyword ?? "")&page=\(page)"
    }
    
    static func businessVenture(page: Int, keyword: String?) -> String {
        return "http://ensb.ssu.ac.kr/web/ensb/23?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_pos=1&p_p_col_count=2&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func businessAccount(page: Int, keyword: String?) -> String {
        return "http://accounting.ssu.ac.kr/web/accounting/3?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_pos=1&p_p_col_count=2&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func businessFinance(page: Int, keyword: String?) -> String {
        return "http://finance.ssu.ac.kr/web/finance/menu5_1?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    // 경제통상대학
    static func economyEconomics(page: Int, keyword: String?) -> String {
        return "http://eco.ssu.ac.kr/web/eco/notice_a?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func economyGlobalCommerce(page: Int, keyword: String?) -> String {
        return "http://pre.ssu.ac.kr/web/itrade/college_i?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    // 사회과학대학
    static func socialWelfare(page: Int, keyword: String?) -> String {
        return "http://pre.ssu.ac.kr/web/mysoongsil/bbs_notice?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func socialAdministration(page: Int, keyword: String?) -> String {
        return "https://pubad.ssu.ac.kr/%EC%A0%95%EB%B3%B4%EA%B4%91%EC%9E%A5/%ED%95%99%EB%B6%80-%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD/page/\(page)/?select=title&keyword=\(keyword ?? "")#038;keyword=\(keyword ?? "")"
    }
    
    static func socialSociology(offset: Int, keyword: String?) -> String {
        return "http://inso.ssu.ac.kr/sub/sub04_01.php?boardid=notice&sk=\(keyword ?? "")&sw=a&category=%ED%95%99%EA%B3%BC%EA%B3%B5%EC%A7%80&offset=\(offset)"
    }
    
    static func socialJournalism(page: Int, keyword: String?) -> String {
        return "http://pre.ssu.ac.kr/web/ssja/20?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func socialLifelong(page: Int, keyword: String?) -> String {
        return "http://lifelongedu.ssu.ac.kr/bbs/board.php?bo_table=univ&sca=&sfl=wr_subject&stx=\(keyword ?? "")&sop=and&page=\(page)"
    }
    
    static func socialPolitical(page: Int, keyword: String?) -> String {
        return "http://pre.ssu.ac.kr/web/psir/board_a?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    // 공과대학
    static func engineerMachineURL(page: Int, keyword: String?) -> String {
        return "https://me.ssu.ac.kr/https://me.ssu.ac.kr/%EA%B2%8C%EC%8B%9C%ED%8C%90-%EC%9E%90%EB%A3%8C%EC%8B%A4/%EA%B3%B5%EC%A7%80%EC%82%AC%ED%95%AD/page/\(page)/?select=title&keyword=\(keyword ?? "")"
    }
    
    static func engineerChemistryURL(offset: Int, keyword: String?) -> String {
        return "http://chemeng.ssu.ac.kr/sub/sub03_01.php?boardid=notice1&sk=\(keyword ?? "")&sw=a&category=&offset=\(offset)"
    }
    
    static func engineerElectricURL(offset: Int, keyword: String?) -> String {
        return "http://ee.ssu.ac.kr/sub/sub05_01.php?boardid=notice&sk=\(keyword ?? "")&sw=a&category=&offset=\(offset)"
    }
    
    static func engineerIndustryURL(page: Int, keyword: String?) -> String {
        return "http://iise.ssu.ac.kr/web/iise/notice?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func engineerOrganicURL(page: Int, keyword: String?) -> String {
        return "http://materials.ssu.ac.kr/bbs/board.php?tbl=notice&&category=&findType=&findWord=\(keyword ?? "")&sort1=&sort2=&it_id=&shop_flag=&mobile_flag=&page=\(page)"
    }
    
    static func engineerArchitectURL() -> String {
        return "http://soar.ssu.ac.kr/schoolofarchi/notice"
    }
    
    // 자연과학대학
    static func naturalMathURL(page: Int, keyword: String?) -> String {
        return "http://math.ssu.ac.kr/web/math/menu3_1?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func naturalChemistryURL(page: Int, keyword: String?) -> String {
        return "http://chem.ssu.ac.kr/web/chem/notice_a?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func naturalPhysicsURL(page: Int, keyword: String?) -> String {
        return "http://physics.ssu.ac.kr/web/physics/41?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func naturalActuaryURL(page: Int, keyword: String?) -> String {
        return "http://stat.ssu.ac.kr/bbs/board.php?bo_table=comm01&sfl=wr_subject&stx=\(keyword ?? "")&sop=and&page=\(page)"
    }
    
    static func naturalBioURL(page: Int, keyword: String?) -> String {
        return "http://bio.ssu.ac.kr/34?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    // 법과대학
    static func lawURL(page: Int, keyword: String?) -> String {
        return "http://law.ssu.ac.kr/web/law/board1?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func intlLawURL(page: Int, keyword: String?) -> String {
        return "http://lawyer.ssu.ac.kr/web/lawyer/27?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    // 인문대학
    static func korlanURL(page: Int, keyword: String?) -> String {
        return "http://korlan.ssu.ac.kr/web/korlan/notice_a?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func englanURL(page: Int, keyword: String?) -> String {
        return "http://pre.ssu.ac.kr/web/englan/10?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func germanURL(page: Int, keyword: String?) -> String {
        return "http://gerlan.ssu.ac.kr/web/gerlan/notice_b?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func frenchURL(page: Int, keyword: String?) -> String {
        return "http://france.ssu.ac.kr/web/france/21?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func japaneseURL(page: Int, keyword: String?) -> String {
        return "http://japanstu.ssu.ac.kr/web/japanstu/notice?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func chineseURL(page: Int, keyword: String?) -> String {
        return "http://chilan.ssu.ac.kr/web/chilan/notice_a?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func philoURL(page: Int, keyword: String?) -> String {
        return "http://pre.ssu.ac.kr/web/phil/13?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func historyURL(page: Int, keyword: String?) -> String {
        return "http://history.ssu.ac.kr/web/history/community_a?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
    
    static func writingURL(page: Int, keyword: String?) -> String {
//        if !(keyword ?? "").isEmpty {
//            return "http://writing.ssu.ac.kr/bbs/bbs.php?table=board_notice&where=ALL&keyword=\(keyword!)&search_step=1&search_sql=BB_NAME%20LIKE%20'%7C%7C%7C\(keyword!)%7C%7C%7C'%20OR%20BB_SUBJECT%20LIKE%20'%7C%7C%7C\(keyword!)%7C%7C%7C'%20OR%20BB_CONTENT%20LIKE%20'%7C%7C%7C\(keyword!)%7C%7C%7C'&p=\(page)"
//        } else {
//            return "http://writing.ssu.ac.kr/bbs/bbs.php?table=board_notice&p=\(page)"
//        }
        return "http://writing.ssu.ac.kr/bbs/bbs.php?table=board_notice&p=\(page)"
    }
    
    // 융합특성화 자유전공학부
    static func convergenceURL(page: Int, keyword: String?) -> String {
        return "http://pre.ssu.ac.kr/web/convergence/32?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=\(keyword ?? "")&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=title&_EXT_BBS_sKeyword=\(keyword ?? "")&_EXT_BBS_curPage=\(page)"
    }
}

class NoticeURL {
    
    // 자연과학대학
    static var naturalScienceMathURL = "http://math.ssu.ac.kr/web/math/menu3_1?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    static var naturalSciencePhysicsURL = "http://physics.ssu.ac.kr/web/physics/41?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    static var naturalScienceChemistryURL = "http://chem.ssu.ac.kr/web/chem/notice_a?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    static var naturalScienceActuarialURL = "http://stat.ssu.ac.kr/bbs/board.php?bo_table=comm01&page="
    
    static var naturalScienceBiomedicalURL = "http://bio.ssu.ac.kr/34?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    // 경영대학
    static var businessBizURL = "http://biz.ssu.ac.kr/bbs/list.do?&bId=BBS_03_NOTICE&sc_title=&page="
    
    static var businessVentureURL = "http://ensb.ssu.ac.kr/web/ensb/23?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_pos=1&p_p_col_count=2&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    static var businessAccountURL = "http://accounting.ssu.ac.kr/web/accounting/3?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_pos=1&p_p_col_count=2&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    static var businessFinanceURL = "http://finance.ssu.ac.kr/web/finance/menu5_1?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    // 경제통상대학
    static var economyEconomicURL = "http://eco.ssu.ac.kr/web/eco/notice_a?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    static var economyGlobalCommerceURL = "http://pre.ssu.ac.kr/web/itrade/college_i?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    // 사회과학대학
    static var socialWelfareURL = "http://pre.ssu.ac.kr/web/mysoongsil/bbs_notice?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    static var socialAdministrationURL = "https://pubad.ssu.ac.kr/%ec%a0%95%eb%b3%b4%ea%b4%91%ec%9e%a5/%ed%95%99%eb%b6%80-%ea%b3%b5%ec%a7%80%ec%82%ac%ed%95%ad/page/"
    
    // offset 0이 page 1, offset 10이 page 2 => (page - 1) * 10 = offset
    static var socialSociologyURL = "http://inso.ssu.ac.kr/sub/sub04_01.php?boardid=notice&sk=&sw=&category=%ED%95%99%EA%B3%BC%EA%B3%B5%EC%A7%80&offset="
    
    static var socialJournalismURL = "http://pre.ssu.ac.kr/web/ssja/20?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    static var socialLifeLongURL = "http://lifelongedu.ssu.ac.kr/bbs/board.php?bo_table=univ&page="
    
    static var socialPoliticsURL = "http://pre.ssu.ac.kr/web/psir/board_a?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
    
    static var mixURL = "http://pre.ssu.ac.kr/web/convergence/32?p_p_id=EXT_BBS&p_p_lifecycle=0&p_p_state=normal&p_p_mode=view&p_p_col_id=column-1&p_p_col_count=1&_EXT_BBS_struts_action=%2Fext%2Fbbs%2Fview&_EXT_BBS_sCategory=&_EXT_BBS_sTitle=&_EXT_BBS_sWriter=&_EXT_BBS_sTag=&_EXT_BBS_sContent=&_EXT_BBS_sCategory2=&_EXT_BBS_sKeyType=&_EXT_BBS_sKeyword=&_EXT_BBS_curPage="
}

extension String {
    func encodeUrl() -> String? {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    func decodeUrl() -> String? {
        return self.removingPercentEncoding
    }
}

