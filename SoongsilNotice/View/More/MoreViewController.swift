//
//  MoreViewController.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/11.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import UIKit
import SafariServices
import WatchConnectivity

class MoreViewController : BaseViewController, UITableViewDelegate, UITableViewDataSource {
    let moreMenu = ["북마크", "오픈소스 사용 정보", "개발자 정보", "개발자 GitHub 방문하기", "추천 앱 사용하기", "광고 문의하기"]
    @IBOutlet var moreTableView: UITableView!
    @IBOutlet var majorLbl: UILabel!
    
    @IBOutlet var btnModifyProfile: UIButton!
    @IBOutlet weak var versionContainerView: UIView!
    
    var session: WCSession?
    
    override func viewDidLoad() {
        self.moreTableView.delegate = self
        self.moreTableView.dataSource = self
        self.moreTableView.separatorInset  = .zero
        self.moreTableView.tableFooterView = UIView(frame: .zero)
        
        self.configureWatchKitSesstion()
        
        let versionView = VersionInfoView.viewFromNib()
        
        versionView.version = Version(currentVersion: NotissuProperty.currentVersion, recentVersion: NotissuProperty.recentVersion, isUpdateRequired: NotissuProperty.isUpdateRequired)
        
        versionContainerView.addSubview(versionView)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onLoadFromWidget),
                                               name: NSNotification.Name("widget"),
                                               object: nil)
        
        self.btnModifyProfile.layer.borderColor = UIColor(named: "notissuAccent1000s")?.cgColor
        self.btnModifyProfile.layer.borderWidth = 1
        
        self.btnModifyProfile.layer.masksToBounds = true
        self.btnModifyProfile.layer.cornerRadius = 6
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "더보기"
        self.majorLbl.text = BaseViewController.noticeDeptName?.rawValue ?? ""
        
        self.checkURLScheme()
    }
    
    @objc func onLoadFromWidget() {
        self.checkURLScheme()
    }
    
    private func configureWatchKitSesstion() {
        
        if WCSession.isSupported() {
            session = WCSession.default
            session?.delegate = self
            session?.activate()
        }
    }
    
    private func checkURLScheme() {
        if let index = NotissuProperty.openIndex {
            print("change to Tab \(index)...")
            if index != self.tabBarController?.selectedIndex {
                self.tabBarController?.selectedIndex = index
            }
        }
    }
    
    @IBAction func onClickModifyProfile(_ sender: Any) {
        let storyBoard = self.storyboard!
        let noticeDetailController = storyBoard.instantiateViewController(withIdentifier: "modifyVC") as? ModifyProfileViewController
        self.navigationController?.pushViewController(noticeDetailController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "moreListCell", for: indexPath) as! MoreTableCell
        cell.lblTitle.text = moreMenu[indexPath.row]
        cell.selectionStyle  = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch(indexPath.row) {
        case 0:
            print("0")
            let storyBoard = self.storyboard!
            let bookmarkController = storyBoard.instantiateViewController(withIdentifier: "bookmarkVC") as? BookmarkViewController
            self.navigationController?.pushViewController(bookmarkController!, animated: true)
            break
        case 1:
            let storyBoard = self.storyboard!
            let noticeDetailController = storyBoard.instantiateViewController(withIdentifier: "OpenSourceVC") as? OpenSourceViewController
            self.navigationController?.pushViewController(noticeDetailController!, animated: true)
            break
        case 2:
            showAlert(title: "개발자 정보", msg: "숭실대학교 컴퓨터학부\n14학번 김태인\n\n메일 전송을 위해 메일 앱을 실행합니다.", handler: onClickMailButton(_:))
            break
        case 3:
            showAlert(title: "개발자 GitHub", msg: "개발자의 GitHub 사이트에 접속합니다.", handler: onClickDevelopGitHub(_:))
            break
        case 4:
            showAlert(title: "그라운드 설치", msg: "숭실대 커뮤니티 그라운드를 설치합니다.", handler: onClickRecommendApp(_:))
            break
        case 5:
            showAlert(title: "광고 문의하기", msg: "메일을 통해 광고 문의를 넣어주세요.\ndella.kimko@gmail.com\n메일 앱을 실행합니다.", handler: onClickMailButton(_:))
            break
        default: break
        }
        
    }
    
    @objc func onClickDevelopGitHub(_ action: UIAlertAction) {
        let viewController = SFSafariViewController(url: URL(string: "https://github.com/della-padula")!)
        self.present(viewController, animated: true, completion: nil)
    }
    
    @objc func onClickMailButton(_ action: UIAlertAction) {
        let email = "della.kimko@gmail.com"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
    
    @objc func onClickRecommendApp(_ action: UIAlertAction) {
        if let url = URL(string: "itms-apps://apps.apple.com/kr/app/%EA%B7%B8%EB%9D%BC%EC%9A%B4%EB%93%9C/id1483838254") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
}

extension MoreViewController: WCSessionDelegate {
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        print("received data: \(userInfo)")
        DispatchQueue.main.async {
            if let value = userInfo["watch"] as? String {
                print("received value : \(value)")
            }
        }
    }
}
