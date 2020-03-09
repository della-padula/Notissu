//
//  NoticeDetailPresenter.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/06.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation
import Kanna
import CoreData
import JavaScriptCore

class NoticeDetailPresenter: NoticeDetail {
    private var view: NoticeDetailView?
    
    let htmlStart = "<hml><head><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"><style>html,body{padding:0 5px 5px;margin:0;font-size:18px !important;}iframe,img{max-width:100%;height:auto;}</style></head><bpdy>"
    let htmlEnd = "</bpdy></hml>"
    
    init(view: NoticeDetailView) {
        self.view = view
    }
    
    func isNoticeFavorite(title: String, date: String, major: DeptCode) -> Bool {
        // Retrieve Data From Core Data
        // Favorite 여부를 확인하여 View 에 적용하기 위한 함수
        let managedContext = CoreDataUtil.shared.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "title = %@ AND date = %@ AND deptCode = %i", title, date, major.rawValue)
        var resultCount: Int = 0
        do {
            let result = try managedContext.fetch(fetchRequest)
            
            for _ in result as! [NSManagedObject] {
                resultCount += 1
            }
            print("Retrieve Notice : \(resultCount)")
        } catch {
            print("ERROR")
        }
        
        if resultCount > 0 {
            return true
        }
        return false
    }
    
    func setFavorite(notice: Notice, majorCode: DeptCode, majorName: DeptName, favorite: Bool) {
        // isFavorite이 참이면 Create하고 거짓이면 Delete한다.
        if favorite {
            self.addFavorite(notice: notice, majorCode: majorCode.rawValue, majorName: majorName.rawValue)
        } else {
            self.deleteFavorite(notice: notice, majorCode: majorCode.rawValue)
        }
    }
    
    private func deleteFavorite(notice: Notice, majorCode: Int) {
        let managedContext = CoreDataUtil.shared.persistentContainer.viewContext
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Favorite")
        fetchRequest.predicate = NSPredicate(format: "title = %@ AND date = %@ AND deptCode = %i", notice.title!, notice.date!, majorCode)
        
        do {
            let result = try managedContext.fetch(fetchRequest)
            let objectToDelete = result[0] as! NSManagedObject
            print("result : \(objectToDelete.value(forKey: "title") ?? "")")
            managedContext.delete(objectToDelete)

            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
    
    private func addFavorite(notice: Notice, majorCode: Int, majorName: String) {
        let managedContext = CoreDataUtil.shared.persistentContainer.viewContext
        
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        
        let noticeObject = NSManagedObject(entity: favoriteEntity, insertInto: managedContext)
        
        noticeObject.setValue(notice.author, forKey: "author")
        noticeObject.setValue(notice.date, forKey: "date")
        noticeObject.setValue(majorCode, forKey: "deptCode")
        noticeObject.setValue(majorName, forKey: "deptName")
        noticeObject.setValue(notice.isNotice, forKey: "isNotice")
        noticeObject.setValue(notice.title, forKey: "title")
        noticeObject.setValue(notice.url, forKey: "url")
        noticeObject.setValue(notice.hasAttachment, forKey: "hasAttachment")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func parseDormitory(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("td[class=descript]").first?.innerHTML ?? ""
        let detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        var attachmentList = [Attachment]()
        
        for attachment in html.css("td[align=left] a") {
            print("🚨...\(attachment.text) - \(attachment["href"])")
            if let fileName = attachment.text?.replacingOccurrences(of: "첨부)", with: ""), let fileLink = attachment["href"] {
                attachmentList.append(Attachment(fileName: fileName, fileURL: fileLink))
            }
        }
        
        completion(attachmentList, detailHTML)
    }
    
    func parseSoongsil(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void) {
        var index = 0
        var contentHTML = ""
        for div in html.css("div[class^='bg-white p-4 mb-5'] div") {
            if index == 4 {
                contentHTML = div.toHTML ?? ""
            }
            index += 1
        }
        
        let detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        var attachmentList = [Attachment]()
        
        for attachment in html.css("ul[class^='download-list mt-5'] li") {
            let link = "https://scatch.ssu.ac.kr/\(attachment.css("a").first?["href"] ?? "")"
            let title = (attachment.css("a span").first?.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            
            print(link)
            print(title)
            
            attachmentList.append(Attachment(fileName: title, fileURL: link))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseComputer(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("td[class=content]").first?.innerHTML ?? ""
        
        let detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        var attachmentList = [Attachment]()
        
        let attachmentHTML = html.xpath("//span[@class='file']/a")
        var attachmentNames = Array<XMLElement>()
        attachmentNames.append(contentsOf: attachmentHTML.reversed())
        
        for name in attachmentNames {
            let fileUrl = "http://cse.ssu.ac.kr\(name["href"] ?? "")"
            let fileName = name.content
            
            if !(name["href"] ?? "").isEmpty {
                attachmentList.append(Attachment(fileName: fileName!, fileURL: fileUrl))
            }
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseElectric(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='content']").first?.innerHTML ?? ""
        
        let detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        
        let attachments = html.css("div[class^='attach'] a")
        var attachmentList = [Attachment]()
        for attachment in attachments {
            let fileUrl = "http://infocom.ssu.ac.kr\(attachment["href"]!)"
            attachmentList.append(Attachment(fileName: attachment.text!, fileURL: fileUrl))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseSoftware(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void) { 
        let contentHTML = html.css("div[class^='bo_view_2']").first?.innerHTML ?? ""
        //        let downloadUrl = "https://sw.ssu.ac.kr/bbs/download.php?bo_table=sub6_1&wr_id=1023&no=1"
        let detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        var attachmentList = [Attachment]()
        
        var index = 0
        for link in html.css("div[class^='bo_view_1'] a") {
            let url = link["href"]?.getArrayAfterRegex(regex: "[=](.*?)[&]")[1] ?? ""
            let fileName = link["href"]?.getArrayAfterRegex(regex: "['](.*?)[']")[1].decodeUrl() ?? ""
            let wr_id = url.replacingOccurrences(of: "&", with: "").replacingOccurrences(of: "=", with: "")
            
            let realUrl = "https://sw.ssu.ac.kr/bbs/download.php?bo_table=sub6_1&wr_id=\(wr_id)&no=\(index)"
            attachmentList.append(Attachment(fileName: fileName.replacingOccurrences(of: "'", with: ""), fileURL: realUrl))
            index += 1
        }
        
        completion(attachmentList, detailHTML)
    }
    
    func parseMedia(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("td[class^='s_default_view_body_2']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        let host = "http://media.ssu.ac.kr"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host )/")
        
        let mediaUrl = "http://media.ssu.ac.kr/"
        var attachmentList = [Attachment]()
        
        for link in html.css("td[width^=480] a") {
            let url = "\(mediaUrl)\(link["href"] ?? "")"
            print("media : \(url)")
            attachmentList.append(Attachment(fileName: link.text ?? "", fileURL: url))
        }
        
        completion(attachmentList, detailHTML)
    }
    
    func parseLaw(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        let detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            //            print(link["href"])
            //            print(link.content)
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        
        completion(attachmentList, detailHTML)
    }
    
    func parseIntlLaw(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        let detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            //            print(link["href"])
            //            print(link.content)
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        
        completion(attachmentList, detailHTML)
    }
    
    func parseInmun(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        
        completion(attachmentList, detailHTML)
    }
    
    func parseWriting(html: HTMLDocument, uid: String?, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let tables = html.css("span[id^='PrintLayer\(uid ?? "")'] table").makeIterator()
        let _ = tables.next()
        var contentHTML: String?
        
        guard let contentTable = tables.next() else {
            return
        }
        
        for (index, tr) in contentTable.css("tr").enumerated() {
            switch index {
            case 4:
                // Content
                contentHTML = tr.innerHTML ?? ""
            default:
                break
            }
        }
        
        let detailHTML = "\(htmlStart)\(contentHTML ?? "")\(htmlEnd)"
        completion([Attachment](), detailHTML)
    }
    
    // 공과대학
    // 화학공학과
    func parseEngineerChemistry(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='body']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"", with: "src=\"http://chemeng.ssu.ac.kr")
        print(detailHTML)
        completion([Attachment](), detailHTML)
    }
    
    // 기계공학과
    func parseEngineerMachine(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='td_box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        // MARK: Needs to be updated
//        for link in html.css("table[class='bbs-view'] a") {
//            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
//        }
        
        completion(attachmentList, detailHTML)
    }
    
    func parseEngineerElectric(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='body']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("div[class='fileLayer'] a") {
            let arguments = link["href"]?.getArrayAfterRegex(regex: "[(](.*?)[)]") ?? []
            if arguments.count > 0 {
                let params = arguments[0].replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "'", with: "")
                let boardId = params.split(separator: ",")[0]
                let bIndex = params.split(separator: ",")[1]
                let index = params.split(separator: ",")[2]
                
                let attachmentURL = "http://ee.ssu.ac.kr/module/board/download.php?boardid=\(boardId)&b_idx=\(bIndex)&idx=\(index)"
                print(attachmentURL)
                attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: attachmentURL))
            }
        }
        //        attachmentList.remove(at: attachmentList.count - 1)
        completion(attachmentList, detailHTML)
    }
    
    func parseEngineerIndustry(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            //            print(link["href"])
            //            print(link.content)
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseEngineerArchitect(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let fullHTML = html.css("table[class='table'] tr")
        var contentHTML = ""
        var attachmentList = [Attachment]()
        
        for tr in fullHTML {
            // 마지막 제외하고 모두 첨부파일임
            print(tr.css("td p").count)
            if tr.css("td p").count < 1 {
                print("attachment")
                let fileName = tr.css("a").first?.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                let fileLink = tr.css("a").first?["href"]?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
                print("\(host!)\(fileLink)")
                attachmentList.append(Attachment(fileName: fileName, fileURL: "\(host!)\(fileLink)"))
            } else {
                print("content")
                contentHTML = tr.innerHTML ?? ""
                break
            }
        }
        
        let detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        // Attachment Format
        // http://soar.ssu.ac.kr/upload/20191008184403_붙임1-이수구분-변경-기준.hwp
        completion(attachmentList, detailHTML)
    }
    
    func parseNaturalMath(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            //            print(link["href"])
            //            print(link.content)
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseNaturalPhysics(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            //            print(link["href"])
            //            print(link.content)
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseNaturalChemistry(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseNaturalActuarial(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("section[id^='bo_v_atc']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("section[id='bo_v_file'] a") {
            attachmentList.append(Attachment(fileName: link.css("strong").first?.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseNaturalMedical(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseBusinessBiz(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[id^='postContents']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("ul[id='postFileList'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: "\(host ?? "")\(link["href"] ?? "")" ))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseBusinessVenture(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            //            print(link["href"])
            //            print(link.content)
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseBusinessAccount(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseBusinessFinance(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseEconomyEconomics(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseEconomyGlobalCommerce(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    // 사회과학대학
    func parseSocialWelfare(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseSocialAdministration(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='td_box']").first?.innerHTML ?? ""
        let detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        var attachmentList = [Attachment]()
        
        for link in html.css("ul[class='flie_list'] li a") {
            let fileUrl = link["href"] ?? ""
            let fileName = (link.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            attachmentList.append(Attachment(fileName: fileName, fileURL: fileUrl))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseSocialSociology(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        //view_content
        let contentHTML = html.css("div[class='view_content']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("div[class='board_view'] a") {
            let arguments = link["href"]?.getArrayAfterRegex(regex: "[(](.*?)[)]") ?? []
            if arguments.count > 0 {
                let params = arguments[0].replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: "'", with: "")
                let boardId = params.split(separator: ",")[0]
                let bIndex = params.split(separator: ",")[1]
                let index = params.split(separator: ",")[2]
                
                let attachmentURL = "\(host ?? "")/module/board/download.php?boardid=\(boardId)&b_idx=\(bIndex)&idx=\(index)"
                attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: attachmentURL))
            }
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseSocialJournalism(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseSocialLifeLong(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("span[id='writeContents']").first?.toHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        var index = 0
        for link in html.css("div[id='content'] a") {
            if index > 1 {
                if "\(link["href"] ?? "")".contains("download") && link["href"]?.getArrayAfterRegex(regex: "[=](.*?)[&]").count ?? 0 > 1 {
                    let url = link["href"]?.getArrayAfterRegex(regex: "[=](.*?)[&]")[1] ?? ""
                    let wr_id = url.replacingOccurrences(of: "&", with: "").replacingOccurrences(of: "=", with: "")
                    let realUrl = "http://lifelongedu.ssu.ac.kr/bbs/download.php?bo_table=univ&wr_id=\(wr_id)&no=\(index - 2)"
                    attachmentList.append(Attachment(fileName: link.css("span").first?.content ?? "", fileURL: realUrl))
                }
            }
            index += 1
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseSocialPolitical(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
    
    func parseConvergence(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void) {
        let contentHTML = html.css("div[class^='frame-box']").first?.innerHTML ?? ""
        var detailHTML = "\(htmlStart)\(contentHTML)\(htmlEnd)"
        detailHTML = detailHTML.replacingOccurrences(of: "src=\"/", with: "src=\"\(host ?? "")/")
        var attachmentList = [Attachment]()
        
        for link in html.css("table[class='bbs-view'] a") {
            attachmentList.append(Attachment(fileName: link.content ?? "", fileURL: link["href"] ?? ""))
        }
        completion(attachmentList, detailHTML)
    }
}
