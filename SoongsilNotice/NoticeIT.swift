//
//  NoticeIT.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/05.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import Kanna

class NoticeIT {
    static func parseListComputer(page: Int, completion: @escaping ([Notice]) -> Void) {
        var noticeList = [Notice]()
        var authorList = [String]()
        var titleList  = [String]()
        var pageStringList = [String]()
        var dateStringList = [String]()
        let noticeUrl = "http://cse.ssu.ac.kr/03_sub/01_sub.htm?page=\(page)&key=&keyfield=&category=&bbs_code=Ti_BBS_1"
        
        var index = 0
        
        guard let main = URL(string: noticeUrl) else {
            print("Error: \(noticeUrl) doesn't seem to be a valid URL")
            return
        }
        do {
            let noticeItemMain = try String(contentsOf: main, encoding: .utf8)
            let doc = try HTML(html: noticeItemMain, encoding: .utf8)
            for product in doc.xpath("//table/tbody/tr/*") {
                if product.nextSibling?.className ?? "" == "center" {
                    let noticeAuthor = product.nextSibling?.text ?? ""
                    let noticeDate = product.nextSibling?.nextSibling?.text ?? ""
                    let pageString = product.at_xpath("a")?["href"] ?? ""
                    
                    switch index % 2 {
                    case 0:
                        let noticeTitle = product.content ?? ""
                        authorList.append(noticeAuthor)
                        titleList.append(noticeTitle)
                        pageStringList.append("http://cse.ssu.ac.kr/03_sub/01_sub.htm\(pageString)")
                        dateStringList.append(noticeDate)
                        break;
                    case 1:  break;
                    default: break
                    }
                    index += 1
                }
            }
        } catch let error {
            print("Error : \(error)")
        }
        
        index = 0
        if authorList.count < 1 {
            ConfigSetting.canFetchData = false
        }
        
        for _ in authorList {
            //            print("index : \(index) , title : \(titleList[index]), author : \(authorList[index]), date : \(dateStringList[index])")
            let noticeItem = Notice(author: authorList[index], title: titleList[index], url: pageStringList[index], date: dateStringList[index])
            
            noticeList.append(noticeItem)
            index += 1
        }
        
        completion(noticeList)
    }
    
    static func parseListMedia(page: Int, completion: @escaping ([Notice]) -> Void) {
        var noticeList = [Notice]()
        var authorList = [String]()
        var titleList  = [String]()
        var pageStringList = [String]()
        var dateStringList = [String]()
        let noticeUrl = "http://media.ssu.ac.kr/sub.php?code=XxH00AXY&mode=&category=1&searchType=&search=&orderType=&orderBy=&page=\(page)"
        //        let noticeUrl = "http://www.naver.com"
        
        var index = 0
        
        Alamofire.request(noticeUrl).responseString(encoding: .utf8) { response in
            //            print("\(response.result.isSuccess)")
            //            print(response.result.value ?? "")
            switch(response.result) {
            case .success(_):
                if let data = response.result.value {
                    print(data)
                    do {
                        let doc = try HTML(html: data, encoding: .utf8)
                        for product in doc.xpath("//table/tbody/tr/*") {
                            print(product.content)
                        }
                    } catch let error {
                        print("Error : \(error)")
                    }
                }
                
            case .failure(_):
                print("Error message:\(response.result.error)")
                break
            }
        }
    }
    
    func parseListSoftware(content: String) {
        
    }
    
    static func parseListElectric(page: Int, completion: @escaping ([Notice]) -> Void) {
        let noticeUrl = "http://infocom.ssu.ac.kr/rb/?c=2/38&p=\(page)"
        var noticeList = [Notice]()
        var authorList = [String]()
        var titleList  = [String]()
        var urlList = [String]()
        var dateStringList = [String]()
        var index = 0
        
        Alamofire.request(noticeUrl).responseString(encoding: .utf8) { response in
            //            print("\(response.result.isSuccess)")
            //            print(response.result.value ?? "")
            switch(response.result) {
            case .success(_):
                if let data = response.result.value {
//                    print(data)
                    do {
                        let doc = try HTML(html: data, encoding: .utf8)
                        for product in doc.css("div[class^='list']") {
                            print("http://infocom.ssu.ac.kr\((product.toHTML?.getArrayAfterRegex(regex: "(?=')\\S+(?=')")[0].split(separator: "'")[0] ?? "")!.replacingOccurrences(of: "&amp;", with: "&"))")
                            
                            let url = "http://infocom.ssu.ac.kr\((product.toHTML?.getArrayAfterRegex(regex: "(?=')\\S+(?=')")[0].split(separator: "'")[0] ?? "")!.replacingOccurrences(of: "&amp;", with: "&"))"
                            
                            let strs = (product.css("div[class^='info']").first?.text ?? "")!.split(separator: "|")
                            
                            urlList.append(url)
                            authorList.append(strs[0].trimmingCharacters(in: .whitespacesAndNewlines))
                            dateStringList.append(strs[1].trimmingCharacters(in: .whitespacesAndNewlines))
                            titleList.append((product.css("span[class^='subject']").first?.text ?? "")!)
                        }
                    } catch let error {
                        print("Error : \(error)")
                    }
                }
                
                index = 0
                for _ in authorList {
                    let noticeItem = Notice(author: authorList[index], title: titleList[index], url: urlList[index], date: dateStringList[index])
                    noticeList.append(noticeItem)
                    index += 1
                }
                
                completion(noticeList)
            case .failure(_):
                print("Error message:\(String(describing: response.result.error))")
                break
            }
        }
    }
    
    func parseListSmartSystem(content: String) {
        
    }
    
    func parseListMediaOper(content: String) {
        
    }
}

extension String{
    func getArrayAfterRegex(regex: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
