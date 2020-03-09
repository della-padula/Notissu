//
//  NoticeAttachmentCell.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/07.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import UIKit
import Alamofire

protocol AttachmentDelegate : class {
    func showDocumentInteractionController(filePath: String)
    func showIndicator()
}

class NoticeAttachmentCell: UITableViewCell {
    @IBOutlet var attachmentTitle: UILabel!
    @IBOutlet var btnDownload: UIButton!
    @IBOutlet var fileTypeIcon: UIImageView!
    
    weak var cellDelegate : AttachmentDelegate?
    var majorCode: DeptCode?
    var fileName = String()
    var fileDownloadURL = String()
    var viewController: BaseViewController?
    
    var attachment: Attachment? {
        didSet {
            self.applyAttachmentToView()
        }
    }
    
    @IBAction func onClickDownload(_ sender: Any) {
        showAlert(title: "파일 다운로드", msg: "파일을 다운로드하시겠습니까?", handler: doDownloadFile(_:))
    }
    
    private func applyAttachmentToView() {
        self.fileName = self.attachment?.fileName ?? ""
        self.attachmentTitle.text = self.attachment?.fileName ?? ""
        self.fileTypeIcon.image = attachment?.fileName.fileTypeIcon.iconImage
        self.fileDownloadURL = self.attachment?.fileURL ?? ""
    }
    
    func doDownloadFile(_ action: UIAlertAction) {
        var encodedUrl = self.fileDownloadURL
        if majorCode ?? DeptCode.IT_Computer == DeptCode.LAW_IntlLaw
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Inmun_Korean
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Inmun_French
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Inmun_Chinese
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Inmun_English
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Inmun_History
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Inmun_Philosophy
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Inmun_Japanese
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Inmun_Writing
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Engineering_Machine
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Engineering_Industrial
            || majorCode ?? DeptCode.IT_Computer == DeptCode.NaturalScience_Math
            || majorCode ?? DeptCode.IT_Computer == DeptCode.NaturalScience_Physics
            || majorCode ?? DeptCode.IT_Computer == DeptCode.NaturalScience_Chemistry
            || majorCode ?? DeptCode.IT_Computer == DeptCode.NaturalScience_Medical
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Business_biz
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Business_venture
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Business_Account
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Business_Finance
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Economy_Economics
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Economy_GlobalCommerce
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Social_Welfare
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Social_Administration
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Social_Sociology
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Social_Journalism
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Social_LifeLong
            || majorCode ?? DeptCode.IT_Computer == DeptCode.Social_Political
            || majorCode ?? DeptCode.IT_Computer == DeptCode.MIX_mix {
            encodedUrl = self.fileDownloadURL
        } else {
            encodedUrl = self.fileDownloadURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        }
        self.cellDelegate?.showIndicator()
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(self.fileName)

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        Alamofire.download(encodedUrl, to: destination)
            .downloadProgress { progress in
                print("Download Progress: \(progress.fractionCompleted)")
        }
        .response { response in
            debugPrint(response)
            
            if let filePath = response.destinationURL?.path {
                self.cellDelegate?.showDocumentInteractionController(filePath: filePath)
            }
        }
        print("B")
    }
    
    func showAlert(title: String, msg: String, handler: ((UIAlertAction) -> Swift.Void)?){
        
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        
        let yesButton = UIAlertAction(title: "예", style: .default, handler: handler)
        alertController.addAction(yesButton)
        
        let noButton = UIAlertAction(title: "아니요", style:.destructive, handler: nil)
        alertController.addAction(noButton)
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
}
