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
    
    @IBOutlet weak var majorContainer       : UIView!
    @IBOutlet weak var currentMajorContainer: UIView!
    @IBOutlet weak var majorButtonContainer : UIView!
    
    // Current Container
    @IBOutlet weak var currentTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentLeftConstraint: NSLayoutConstraint!
    @IBOutlet weak var currentBadgeWidth: NSLayoutConstraint!
    
    private var majorCount = 9
    
    // Major Container
    @IBOutlet var bgViews    : [UIView]!
    @IBOutlet var lblNames   : [UILabel]!
    @IBOutlet var lblEngNames: [UILabel]!
    @IBOutlet var imageMajors: [UIImageView]!
    
    // Major Button Container
    @IBAction func onClickMajor(sender: UIButton) {
        print("On Click Major ... sender.tag : \(sender.tag)")
        if sender.tag > (majorCount - 1) {
            
        } else {
            self.setActiveView(index: sender.tag)
        }
    }
    
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
        
        self.majorSectionCollectionView.delegate = self
        self.majorSectionCollectionView.dataSource = self
        
        self.majorContainer.layer.borderColor = UIColor.MONO200.cgColor
        self.majorContainer.layer.borderWidth = 1.0
//        self.majorContainer.backgroundColor =
        
        let delayInSeconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.majorSectionCollectionView.selectItem(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .left)
            
            self.setMajorToView()
        }
    }
    
    private func setActiveView(index: Int) {
        print("setActiveView at : \(index)")
    }
    
    private func setMajorToView() {
        self.initializeViews()
        
        var majorList = [Major]()
        
        if selectedIndex == 0 {
            majorList = MajorModel.majorListIT
        } else if selectedIndex == 1 {
            majorList = MajorModel.majorListBusiness
        } else if selectedIndex == 2 {
            majorList = MajorModel.majorListEconomy
        } else if selectedIndex == 3 {
            majorList = MajorModel.majorListEngineer
        } else if selectedIndex == 4 {
            majorList = MajorModel.majorListLaw
        } else if selectedIndex == 5 {
            majorList = MajorModel.majorListSocial
        } else if selectedIndex == 6 {
            majorList = MajorModel.majorListInmun
        } else if selectedIndex == 7 {
            majorList = MajorModel.majorListNatural
        } else if selectedIndex == 8 {
            majorList = [MajorModel.majorConvergence]
        } else if selectedIndex == 9 {
            majorList = MajorModel.majorListSoongsil
        }
        
        majorCount = majorList.count
        
        for (index, major) in majorList.enumerated() {
            for lblName in lblNames {
                if index == lblName.tag {
                    lblName.text = major.majorName.map {  $0.rawValue }
                }
            }
            
            for lblEngName in lblEngNames {
                if index == lblEngName.tag {
                    lblEngName.text = major.majorNameEng.map {  $0.rawValue }
                }
            }
            
            for imageMajor in imageMajors {
                if index == imageMajor.tag {
                    imageMajor.isHidden = false
                }
            }
            
            for bgView in bgViews {
                if index == bgView.tag {
                    self.addBorderToView(curIndex: index, maxIndex: (majorList.count - 1))
                }
            }
        }
    }
    
    private func addBorderToView(curIndex: Int, maxIndex: Int) {
        let row = curIndex / 3
        let column = curIndex % 3
        
        print("\nrow : \(row), column : \(column)")
        print("---------------------")
        
        if row == 0 && column == 0 {
            if curIndex == maxIndex {
                self.drawBorder(view: bgViews[curIndex], top: 1.0, bottom: 1.0, left: 1.0, right: 1.0, color: .MONO200)
            } else {
                self.drawBorder(view: bgViews[curIndex], top: 1.0, bottom: 0.5, left: 1.0, right: 0.5, color: .MONO200)
            }
        } else if row == 0 && column == 1 {
            self.drawBorder(view: bgViews[curIndex], top: 1.0, bottom: 0.5, left: 0.5, right: 0.5, color: .MONO200)
        } else if row == 0 && column == 2 {
            self.drawBorder(view: bgViews[curIndex], top: 1.0, bottom: 0.5, left: 0.5, right: 1.0, color: .MONO200)
        } else if row == 1 && column == 0 {
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.5, left: 1.0, right: 0.5, color: .MONO200)
        } else if row == 1 && column == 1 {
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.5, left: 0.5, right: 0.5, color: .MONO200)
            if curIndex == maxIndex {
                self.drawBorder(view: bgViews[5], top: 0.5, bottom: 0.0, left: 0.5, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[6], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[7], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
            } else {
                self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.5, left: 0.5, right: 0.5, color: .MONO200)
            }
        } else if row == 1 && column == 2 {
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.5, left: 0.5, right: 1.0, color: .MONO200)
        } else if row == 2 && column == 0 {
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 1.0, left: 1.0, right: 0.5, color: .MONO200)
        } else if row == 2 && column == 1 {
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 1.0, left: 0.5, right: 0.5, color: .MONO200)
        } else if row == 2 && column == 2 {
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 1.0, left: 0.5, right: 1.0, color: .MONO200)
        }
    }
    
    private func drawBorder(view: UIView, top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat, color: UIColor) {
        print("drawerBorder...top:\(top) / bottom:\(bottom) / left:\(left) / right:\(right)")
        view.layoutIfNeeded()
        view.layer.addBorder(edge: .top, color: color, thickness: top)
        view.layer.addBorder(edge: .bottom, color: color, thickness: bottom)
        view.layer.addBorder(edge: .left, color: color, thickness: left)
        view.layer.addBorder(edge: .right, color: color, thickness: right)
    }
    
    private func initializeViews() {
        for lblName in lblNames {
            lblName.text = ""
        }
        
        for lblNameEng in lblEngNames {
            lblNameEng.text = ""
        }
        
        for imageMajor in imageMajors {
            imageMajor.isHidden = true
        }
        
        for bgView in bgViews {
            // Remove Drawn Lines
        }
    }
}

extension MyNoticeEditDeptViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "deptSectionTitleCell", for: indexPath) as! DeptSelectTitleCell
        
        cell.lblSectionTitle.alpha = 0.3
        cell.sectionName = sections[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("Selected Section : \(sections[indexPath.row])")
        
        self.selectedIndex = indexPath.row
        self.setMajorToView()
    }
    
}
