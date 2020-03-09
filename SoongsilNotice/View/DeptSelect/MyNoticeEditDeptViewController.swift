//
//  MyNoticeEditDeptViewController.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/03/09.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation
import UIKit

class MyNoticeEditDeptViewController: BaseViewController {
    var sections = ["🖥 IT 대학", "📉 경영대학", "📈 경제통상대학", "🛠 공과대학", "📚 법과대학", "🎙 사회과학대학", "🗣 인문대학", "🌡 자연과학대학", "📖 융합특성화자유전공학부", "⏰ 학교 생활"]
    
    @IBOutlet weak var customNavigationBar: UIView!
    @IBOutlet weak var customNavigationBarTitle: UILabel!
    @IBOutlet weak var majorCollectionView: UICollectionView!
    
    @IBOutlet weak var majorSectionCollectionView: UICollectionView!
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        let transition = CATransition()
         transition.duration = 0.3
         transition.type = CATransitionType.push
         transition.subtype = CATransitionSubtype.fromLeft
        
         view.window!.layer.add(transition, forKey: kCATransition)
         
         self.dismiss(animated: false, completion: nil)
    }
    
    private var selectedIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customNavigationBarTitle.font = .AppleSDBold20P
        self.customNavigationBarTitle.textColor = .MONO0
        self.customNavigationBar.setGradientBackground(colorTop: .MAIN100, colorBottom: .MAIN200)
        
        self.majorCollectionView.delegate = self
        self.majorCollectionView.dataSource = self
        
        self.majorCollectionView.clipsToBounds = true
        self.majorCollectionView.layer.cornerRadius = 3
        self.majorCollectionView.layer.borderWidth = 1
        self.majorCollectionView.layer.borderColor = UIColor.MONO200.cgColor
        
        self.majorSectionCollectionView.delegate = self
        self.majorSectionCollectionView.dataSource = self
        
        let delayInSeconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.majorSectionCollectionView.selectItem(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .left)
        }
    }
}

extension MyNoticeEditDeptViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.majorSectionCollectionView {
            return self.sections.count
        } else {
            if selectedIndex == 0 {
                return MajorModel.majorListIT.count
            } else if selectedIndex == 1 {
                return MajorModel.majorListBusiness.count
            } else if selectedIndex == 2 {
                return MajorModel.majorListEconomy.count
            } else if selectedIndex == 3 {
                return  MajorModel.majorListEngineer.count
            } else if selectedIndex == 4 {
                return MajorModel.majorListLaw.count
            } else if selectedIndex == 5 {
                return MajorModel.majorListSocial.count
            } else if selectedIndex == 6 {
                return MajorModel.majorListInmun.count
            } else if selectedIndex == 7 {
                return MajorModel.majorListNatural.count
            } else if selectedIndex == 8 {
                return 1
            } else if selectedIndex == 9 {
                return MajorModel.majorListSoongsil.count
            } else {
                return 0
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.majorSectionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deptSectionTitleCell", for: indexPath) as! DeptSelectTitleCell
            
            cell.lblSectionTitle.alpha = 0.3
            cell.sectionName = sections[indexPath.row]
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myNoticeDeptSelectCell", for: indexPath) as! MyNoticeDeptSelectCell
            
            print("[a] frame width : \(collectionView.frame.width)")
            
            print("[a] bounds width : \(collectionView.bounds.width)")
            
            print("[a] cell width : \(collectionView.frame.width / 3)")
            
            print("[a] content size : \(collectionView.contentSize)")
            
            cell.width = collectionView.frame.width / 3 - 10
            
                if selectedIndex == 0 {
                    cell.major = MajorModel.majorListIT[indexPath.row]
                } else if selectedIndex == 1 {
                    cell.major = MajorModel.majorListBusiness[indexPath.row]
                } else if selectedIndex == 2 {
                    cell.major = MajorModel.majorListEconomy[indexPath.row]
                } else if selectedIndex == 3 {
                    cell.major = MajorModel.majorListEngineer[indexPath.row]
                } else if selectedIndex == 4 {
                    cell.major = MajorModel.majorListLaw[indexPath.row]
                } else if selectedIndex == 5 {
                    cell.major = MajorModel.majorListSocial[indexPath.row]
                } else if selectedIndex == 6 {
                    cell.major = MajorModel.majorListInmun[indexPath.row]
                } else if selectedIndex == 7 {
                    cell.major = MajorModel.majorListNatural[indexPath.row]
                } else if selectedIndex == 8 {
                    cell.major = MajorModel.majorConvergence
                } else if selectedIndex == 9 {
                    cell.major = MajorModel.majorListSoongsil[indexPath.row]
                }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Selected Section : \(sections[indexPath.row])")
        
        if collectionView == self.majorSectionCollectionView {
            self.selectedIndex = indexPath.row
            self.majorCollectionView.reloadData()
        } else {
            // Change Major
        }
    }
    
}
