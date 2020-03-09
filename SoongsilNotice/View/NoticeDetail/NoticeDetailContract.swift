//
//  NoticeDetailContract.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/06.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation
import UIKit
import Kanna

struct Attachment {
    var fileName: String
    var fileURL: String
}

// View
protocol NoticeDetailView {
    func showWebViewPage(attachments: [Attachment], html: String)
}

// Presenter
protocol NoticeDetail {
    // Attachment : 첨부파일, String : 내용이 담긴 HTML
    func isNoticeFavorite(title: String, date: String, major: DeptCode) -> Bool
    
    func setFavorite(notice: Notice, majorCode: DeptCode, majorName: DeptName, favorite: Bool)
    
    func parseDormitory(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void)
    
    func parseSoongsil(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void)
    
    func parseComputer(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void)
    
    func parseElectric(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void)
    
    func parseSoftware(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void)
    
    func parseMedia(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void)
    
    // 법학과, 국제법무학과
    func parseLaw(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void)
    
    func parseIntlLaw(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void)
    
    // 국문, 불문, 독문, 중문, 영문
    func parseInmun(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void)
    
    func parseWriting(html: HTMLDocument, uid: String?, host: String?, completion: @escaping ([Attachment], String) -> Void)
    
    // 화학공학과
    func parseEngineerChemistry(html: HTMLDocument, completion: @escaping ([Attachment], String) -> Void)
    
    func parseEngineerElectric(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void)
    
    func parseEngineerIndustry(html: HTMLDocument, host: String?, completion: @escaping ([Attachment], String) -> Void)
}
