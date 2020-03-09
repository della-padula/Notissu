//
//  SchoolViewController.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/19.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import UIKit
import GoogleMobileAds

class SchoolViewController: BaseViewController, SchoolView, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var noticeListView: UITableView!
    var spinnerFooter = UIActivityIndicatorView(style: .gray)
    
    private var presenter: SchoolPresenter!
    private var noticeList = [Notice]()
    private var refreshControl      = UIRefreshControl()
    private var page : Int = 1
    
    // Googld Ad
    private var bannerView: GADBannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupBannerView()
        
        if #available(iOS 10.0, *) {
            self.noticeListView.refreshControl = refreshControl
        } else { noticeListView.addSubview(refreshControl) }
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onLoadFromWidget),
                                               name: NSNotification.Name("widget"),
                                               object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.topItem?.title = "SSU:Catch"
        self.presenter = SchoolPresenter(view: self)
        self.noticeListView.delegate = self
        self.noticeListView.dataSource = self
        self.noticeListView.separatorInset = .zero
        self.noticeListView.separatorStyle = .none
        self.noticeListView.tableFooterView = UIView()
        self.noticeListView.reloadData()
        self.refresh()
        
        self.checkURLScheme()
    }
    
    @objc func onLoadFromWidget() {
        self.checkURLScheme()
    }
    
    private func setupBannerView() {
        let adSize = GADAdSizeFromCGSize(CGSize(width: self.view.frame.width, height: 50))
        bannerView = GADBannerView(adSize: adSize)
        
        bannerView.backgroundColor = UIColor(named: "notissuWhite1000s")!
        addBannerViewToView(bannerView)
#if DEBUG
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
#else
        bannerView.adUnitID = "ca-app-pub-8965771939775493/8407428627"
#endif
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: view.safeAreaLayoutGuide,
                                attribute: .bottom,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
        ])
    }
    
    private func checkURLScheme() {
        if let index = NotissuProperty.openIndex {
            print("change to Tab \(index)...")
            if index != self.tabBarController?.selectedIndex {
                self.tabBarController?.selectedIndex = index
            }
        }
    }
    
    func applyTableView(list: [Notice]) -> Void {
        if list.count < 10 {
            ConfigSetting.canFetchData = false
        }
        self.refreshControl.endRefreshing()
        
        self.spinnerFooter.stopAnimating()
        self.noticeListView.tableFooterView?.isHidden = true
        
        self.hideProgressBar()
        self.noticeList.append(contentsOf: list)
        self.noticeListView.reloadData()
    }
    
    @objc func refresh() {
        self.page = 1
        
        if !self.refreshControl.isRefreshing {
            self.showProgressBar()
        }
        
        ConfigSetting.canFetchData = true
        self.noticeList.removeAll()
        self.presenter.parseSchoolNotice(page: 1, keyword: nil)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = self.storyboard!
        let noticeDetailController = storyBoard.instantiateViewController(withIdentifier: "noticeDetailVC") as? NoticeDetailViewController
        
        noticeDetailController?.noticeItem  = noticeList[indexPath.row]
        noticeDetailController?.detailURL   = noticeList[indexPath.row].url
        noticeDetailController?.department  = Major(majorCode: DeptCode.Soongsil, majorName: DeptName.Soongsil)
        noticeDetailController?.noticeTitle = self.noticeList[indexPath.row].title
        noticeDetailController?.noticeDay   = self.noticeList[indexPath.row].date
        self.navigationController?.pushViewController(noticeDetailController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.noticeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noticeListCell", for: indexPath) as! NoticeListViewCell
        if noticeList.count > 0 {
            cell.notice = noticeList[indexPath.row]
        }
        cell.selectionStyle  = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.noticeList.count - indexPath.row == 5 && ConfigSetting.canFetchData {
            // LOAD MORE
            self.spinnerFooter.startAnimating()
            self.spinnerFooter.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.noticeListView.tableFooterView = spinnerFooter
            self.noticeListView.tableFooterView?.isHidden = false
            
            self.page += 1
            self.presenter.parseSchoolNotice(page: page, keyword: nil)
        }
    }
}

extension SchoolViewController: GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
}
