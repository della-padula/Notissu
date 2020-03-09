//
//  HomeViewController.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/07.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    var sections = ["⏰ 학교 생활", "🖥 IT 대학", "📚 법과대학", "🗣 인문대학", "🛠 공과대학", "🌡 자연과학대학", "📉 경영대학", "📈 경제통상대학", "🎙 사회과학대학", "📖 융합특성화자유전공학부"]

    @IBOutlet var majorListView: UITableView!
    @IBOutlet weak var deptSectionTitleView: UICollectionView!
    
    private var isLoaded = false
    
    @objc func onLoadFromWidget() {
        self.checkURLScheme()
    }
    
    private func checkURLScheme() {
        if let index = NotissuProperty.openIndex {
            print("change to Tab \(index)...")
            if index != self.tabBarController?.selectedIndex {
                self.tabBarController?.selectedIndex = index
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.topItem?.title = "전공 목록"
        self.checkURLScheme()
        
        if isLoaded {
            self.deptSectionTitleView.selectItem(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .left)
            isLoaded = true
        }
    }
    
    override func viewDidLoad() {
        self.navigationController?.navigationBar.barStyle = .black
        NotificationCenter.default.addObserver(self, selector: #selector(onLoadFromWidget),
        name: NSNotification.Name("widget"),
        object: nil)
        
        self.deptSectionTitleView.delegate = self
        self.deptSectionTitleView.dataSource = self
        self.deptSectionTitleView.showsHorizontalScrollIndicator = false
        
        self.majorListView.delegate = self
        self.majorListView.dataSource = self
        self.majorListView.tableFooterView = UIView()
        self.majorListView.reloadData()
        
        setNavigationBarTextLayout()
        setGradientNavigationBar()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { return sections.count }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = self.storyboard!
        let noticeListViewController = storyBoard.instantiateViewController(withIdentifier: "noticeListVC") as? NoticeListViewController
        
        if indexPath.section == 0 {
            noticeListViewController?.department = MajorModel.majorListSoongsil[indexPath.row]
        } else if indexPath.section == 1 {
            noticeListViewController?.department = MajorModel.majorListIT[indexPath.row]
        } else if indexPath.section == 2 {
            noticeListViewController?.department = MajorModel.majorListLaw[indexPath.row]
        } else if indexPath.section == 3 {
            noticeListViewController?.department = MajorModel.majorListInmun[indexPath.row]
        } else if indexPath.section == 4 {
            noticeListViewController?.department = MajorModel.majorListEngineer[indexPath.row]
        } else if indexPath.section == 5 {
            noticeListViewController?.department = MajorModel.majorListNatural[indexPath.row]
        } else if indexPath.section == 6 {
            noticeListViewController?.department = MajorModel.majorListBusiness[indexPath.row]
        } else if indexPath.section == 7 {
            noticeListViewController?.department = MajorModel.majorListEconomy[indexPath.row]
        } else if indexPath.section == 8 {
            noticeListViewController?.department = MajorModel.majorListSocial[indexPath.row]
        } else if indexPath.section == 9 {
            noticeListViewController?.department = MajorModel.majorConvergence
        }
        noticeListViewController?.isSearchResult = false
        noticeListViewController?.listType = .normalList
        
        self.navigationController?.pushViewController(noticeListViewController!, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return MajorModel.majorListSoongsil.count
        } else if section == 1 {
            return MajorModel.majorListIT.count
        } else if section == 2 {
            return MajorModel.majorListLaw.count
        } else if section == 3 {
            return MajorModel.majorListInmun.count
        } else if section == 4 {
            return  MajorModel.majorListEngineer.count
        } else if section == 5 {
            return MajorModel.majorListNatural.count
        } else if section == 6 {
            return MajorModel.majorListBusiness.count
        } else if section == 7 {
            return MajorModel.majorListEconomy.count
        } else if section == 8 {
            return MajorModel.majorListSocial.count
        } else if section == 9 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "majorCell", for: indexPath) as! HomeCell
        if indexPath.section == 0 {
            cell.major = MajorModel.majorListSoongsil[indexPath.row]
        } else if indexPath.section == 1 {
            cell.major = MajorModel.majorListIT[indexPath.row]
        } else if indexPath.section == 2 {
            cell.major = MajorModel.majorListLaw[indexPath.row]
        } else if indexPath.section == 3 {
            cell.major = MajorModel.majorListInmun[indexPath.row]
        } else if indexPath.section == 4 {
            cell.major = MajorModel.majorListEngineer[indexPath.row]
        } else if indexPath.section == 5 {
            cell.major = MajorModel.majorListNatural[indexPath.row]
        } else if indexPath.section == 6 {
            cell.major = MajorModel.majorListBusiness[indexPath.row]
        } else if indexPath.section == 7 {
            cell.major = MajorModel.majorListEconomy[indexPath.row]
        } else if indexPath.section == 8 {
            cell.major = MajorModel.majorListSocial[indexPath.row]
        } else if indexPath.section == 9 {
            cell.major = MajorModel.majorConvergence
        } else {
            return UITableViewCell()
        }
        
        cell.selectionStyle  = .none
        return cell
    }
}

extension HomeViewController {
    private func getImageFrom(gradientLayer:CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
    private func setGradientNavigationBar() {
        print("navigationController : \(self.navigationController)")
        print("navigationBar : \(self.navigationController?.navigationBar)")
        print("navigationItem : \(self.navigationController?.navigationItem)")
        
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
            gradient.frame = bounds
            gradient.colors = [UIColor(named: "notissuNaviGradientTop")!.cgColor, UIColor(named: "notissuNaviGradientBottom")!.cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
            
            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deptSectionTitleCell", for: indexPath) as! DeptSelectTitleCell
        
//        cell.isOpaque = true
        cell.lblSectionTitle.alpha = 0.3
        cell.sectionName = sections[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Section : \(sections[indexPath.row])")
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
    }
    
}
