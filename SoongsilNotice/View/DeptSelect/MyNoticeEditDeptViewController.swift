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
    
    @IBOutlet weak var majorContainer       : UIView!
    @IBOutlet weak var currentMajorContainer: UIView!
    @IBOutlet weak var majorButtonContainer : UIView!
    @IBOutlet weak var currentBadge         : UIView!
    
    @IBOutlet weak var btnSave: RoundButton!
    
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
    
    private var selectedIndex = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        self.setNavigationBarLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.majorSectionCollectionView.delegate = self
        self.majorSectionCollectionView.dataSource = self
        
        self.btnSave.adjustsImageWhenHighlighted = false
        
        self.majorContainer.layer.borderColor = UIColor.MONO200.cgColor
        self.majorContainer.layer.borderWidth = 1.0
        self.majorContainer.layer.cornerRadius = 3
        self.majorContainer.backgroundColor = UIColor.T_MAJOR_BG
        
        let delayInSeconds = 0.1
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delayInSeconds) {
            self.majorSectionCollectionView.selectItem(at: IndexPath.init(row: 0, section: 0), animated: false, scrollPosition: .left)
            
            self.setMajorToView()
        }
    }
    
    private func setActiveView(index: Int) {
        print("setActiveView at : \(index)")
        
        let row = index / 3
        let column = index % 3
        let offsetUnit = currentBadgeWidth.constant - 1
        
        let wOffset = offsetUnit * CGFloat(column)
        let hOffset = offsetUnit * CGFloat(row)
        
        currentTopConstraint.constant  = hOffset
        currentLeftConstraint.constant = wOffset
        
        currentBadge.isHidden = false
        currentBadge.layer.borderWidth = 1.5
        currentBadge.layer.borderColor = UIColor.MAIN100.cgColor
    }
    
    private func setMajorToView() {
        self.initializeViews()
        
        var majorList = [Major]()
        currentBadgeWidth.constant = bgViews[0].frame.width + 1
        
        print("BgViews[0] Width : \(bgViews[0].frame.width)")
        print("currentBadgeWidth : \(currentBadgeWidth.constant)")
        print("currentMajorContainerWidth : \(currentMajorContainer.frame.width)")
        
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
            if BaseViewController.noticeDeptCode == major.majorCode {
                self.setActiveView(index: index)
            }
            
            for lblName in lblNames {
                if index == lblName.tag {
                    lblName.isHidden = false

                    var majorText = major.majorName.map { $0.rawValue } ?? ""
                    
                    if BaseViewController.noticeDeptCode == major.majorCode {
                        // My Major
                        lblName.textColor = .MAIN200
                    } else {
                        lblName.textColor = .MONO400
                    }
                    
                    if majorText.split(separator: " ").count > 1 {
                        lblName.font = .AppleSDSemiBold12P
                    } else {
                        lblName.font = .AppleSDSemiBold15P
                    }
                    
                    majorText = majorText.replacingOccurrences(of: " ", with: "\n")
//                    if majorText.count > 5 {
//                        let insertIndex = majorText.index(majorText.startIndex, offsetBy: 6)
//                        print("\(majorText) - \(majorText.count) - \(insertIndex)")
//                        majorText.insert("\n", at: insertIndex)
//                    }
                    
                    lblName.text = majorText
                }
            }
            
            for lblEngName in lblEngNames {
                if index == lblEngName.tag {
                    lblEngName.isHidden = false
                    lblEngName.text = major.majorNameEng.map {  $0.rawValue }
                    
                    if BaseViewController.noticeDeptCode == major.majorCode {
                        // My Major
                        lblEngName.textColor = .MAIN200
                    } else {
                        lblEngName.textColor = .MONO400
                    }
                }
            }
            
            for imageMajor in imageMajors {
                if index == imageMajor.tag {
                    imageMajor.isHidden = false
                    let image = UIImage(named: "major")?.withRenderingMode(.alwaysTemplate)
                    if BaseViewController.noticeDeptCode == major.majorCode {
                        // My Major
                        imageMajor.tintColor = UIColor.MAIN200
                    } else {
                        imageMajor.tintColor = UIColor.MONO400
                    }
                    imageMajor.image = image
                }
            }
            
            for bgView in bgViews {
                if index == bgView.tag {
                    self.addBorderToView(curIndex: index, maxIndex: (majorList.count - 1))
                }
            }
        }
    }
    
    private func setNavigationBarLayout() {
        self.navigationController?.navigationBar.topItem?.title = "전공 선택"
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.AppleSDBold20P, NSAttributedString.Key.foregroundColor: UIColor.MONO0]
        
        self.navigationController?.navigationBar.setTitleVerticalPositionAdjustment(CGFloat(-7), for: UIBarMetrics.default)
    }
    
    private func addBorderToView(curIndex: Int, maxIndex: Int) {
        let row = curIndex / 3
        let column = curIndex % 3
        
        print("\nrow : \(row), column : \(column)")
        print("---------------------")
        
        if row == 0 && column == 0 {
            self.drawBorder(view: bgViews[curIndex], top: 0.0, bottom: 0.5, left: 0.0, right: 0.5, color: .MONO200)
            
            if curIndex == maxIndex {
//                self.drawBorder(view: bgViews[curIndex], top: 1.0, bottom: 1.0, left: 1.0, right: 1.0, color: .MONO200)
                self.drawBorder(view: bgViews[1], top: 0.0, bottom: 0.0, left: 0.5, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[3], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
            } else {
//                self.drawBorder(view: bgViews[curIndex], top: 1.0, bottom: 0.5, left: 1.0, right: 0.5, color: .MONO200)
                self.drawBorder(view: bgViews[curIndex], top: 0.0, bottom: 0.5, left: 0.0, right: 0.5, color: .MONO200)
            }
        } else if row == 0 && column == 1 {
            self.drawBorder(view: bgViews[curIndex], top: 1.0, bottom: 0.5, left: 0.5, right: 0.5, color: .MONO200)
            
            if curIndex == maxIndex {
                self.drawBorder(view: bgViews[2], top: 0.0, bottom: 0.0, left: 0.5, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[3], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[4], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
            }
        } else if row == 0 && column == 2 {
//            self.drawBorder(view: bgViews[curIndex], top: 1.0, bottom: 0.5, left: 0.5, right: 1.0, color: .MONO200)
            self.drawBorder(view: bgViews[curIndex], top: 0.0, bottom: 0.5, left: 0.5, right: 0.0, color: .MONO200)
            
            if curIndex == maxIndex {
                self.drawBorder(view: bgViews[3], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[4], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[5], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
            }
        } else if row == 1 && column == 0 {
//            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.5, left: 1.0, right: 0.5, color: .MONO200)
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.5, left: 0.0, right: 0.5, color: .MONO200)
            
            if curIndex == maxIndex {
                self.drawBorder(view: bgViews[4], top: 0.5, bottom: 0.0, left: 0.5, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[6], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
            }
        } else if row == 1 && column == 1 {
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.5, left: 0.5, right: 0.5, color: .MONO200)
            if curIndex == maxIndex {
                self.drawBorder(view: bgViews[5], top: 0.5, bottom: 0.0, left: 0.5, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[6], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[7], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
            }
        } else if row == 1 && column == 2 {
//            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.5, left: 0.5, right: 1.0, color: .MONO200)
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.5, left: 0.5, right: 0.0, color: .MONO200)
            
            if curIndex == maxIndex {
                self.drawBorder(view: bgViews[6], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[7], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[8], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
            }
        } else if row == 2 && column == 0 {
//            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 1.0, left: 1.0, right: 0.5, color: .MONO200)
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.0, left: 0.0, right: 0.5, color: .MONO200)
            
            if curIndex == maxIndex {
                self.drawBorder(view: bgViews[7], top: 0.5, bottom: 0.0, left: 0.5, right: 0.0, color: .MONO200)
                self.drawBorder(view: bgViews[8], top: 0.5, bottom: 0.0, left: 0.0, right: 0.0, color: .MONO200)
            }
        } else if row == 2 && column == 1 {
//            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 1.0, left: 0.5, right: 0.5, color: .MONO200)
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.0, left: 0.5, right: 0.5, color: .MONO200)
            
            if curIndex == maxIndex {
                self.drawBorder(view: bgViews[8], top: 0.5, bottom: 0.0, left: 0.5, right: 0.0, color: .MONO200)
            }
        } else if row == 2 && column == 2 {
//            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 1.0, left: 0.5, right: 1.0, color: .MONO200)
            self.drawBorder(view: bgViews[curIndex], top: 0.5, bottom: 0.0, left: 0.5, right: 0.0, color: .MONO200)
            
            if curIndex == maxIndex {
                
            }
        }
    }
    
    private func drawBorder(view: UIView, top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat, color: UIColor) {
        print("drawerBorder...top:\(top) / bottom:\(bottom) / left:\(left) / right:\(right)")
        
        view.addBorder(toSide: .Top, withColor: color.cgColor, andThickness: top)
        view.addBorder(toSide: .Bottom, withColor: color.cgColor, andThickness: bottom)
        view.addBorder(toSide: .Left, withColor: color.cgColor, andThickness: left)
        view.addBorder(toSide: .Right, withColor: color.cgColor, andThickness: right)
    }
    
    private func initializeViews() {
        currentBadge.isHidden = true
        
        for lblName in lblNames {
            lblName.isHidden = true
        }
        
        for lblNameEng in lblEngNames {
            lblNameEng.isHidden = true
        }
        
        for imageMajor in imageMajors {
            imageMajor.isHidden = true
        }
        
        for bgView in bgViews {
            // Remove Drawn Lines
//            bgView.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
//            bgView.layer.removeAllBorders()
            
            bgView.removeBorder(toSide: .Top)
            bgView.removeBorder(toSide: .Bottom)
            bgView.removeBorder(toSide: .Left)
            bgView.removeBorder(toSide: .Right)
//            self.drawBorder(view: bgView, top: 0, bottom: 0, left: 0, right: 0, color: .clear)
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
