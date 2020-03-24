//
//  MyNoticeViewController.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2020/03/09.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import Foundation
import UIKit

class MyNoticeViewController: BaseViewController, MyNoticeViewProtocol {
    
    @IBOutlet weak var scrollViewMyNotice: UIScrollView!
    @IBOutlet weak var topSection: UIView!
    @IBOutlet weak var searchSection: UIView!
    @IBOutlet weak var tfSearchKeyword: UITextField!
    @IBOutlet weak var topSectionHeight: NSLayoutConstraint!
    @IBOutlet weak var topBackgroundSectionHeight: NSLayoutConstraint!
    @IBOutlet weak var lblDeptNameHeight: NSLayoutConstraint!
    @IBOutlet weak var lblDeptName: UILabel!
    @IBOutlet var lblProfile: UILabel!
    
    @IBOutlet weak var smallCircle: UIView!
    @IBOutlet weak var largeCircle: UIView!
    
    @IBOutlet var scrollViewWidth: NSLayoutConstraint!
    
    @IBAction func onClickSelectDept(_ sender: Any) {
        let storyBoard = self.storyboard!
        let selectHomeDeptViewController = storyBoard.instantiateViewController(withIdentifier: "selectHomeDeptVC")
//
//        let transition = CATransition()
//        transition.duration = 0.2
//        transition.type = CATransitionType.push
//        transition.subtype = CATransitionSubtype.fromRight
//
//        view.window!.layer.add(transition, forKey: kCATransition)
//
//        selectHomeDeptViewController.modalPresentationStyle = .fullScreen
//
//        
        self.navigationController?.pushViewController(selectHomeDeptViewController, animated: true)
//        self.present(selectHomeDeptViewController, animated: false, completion: nil)
    }
    
    private var presenter: MyNoticePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = MyNoticePresenter(view: self)
        
        self.setGradientNavigationBar()
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        setLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
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
        
        if let navigationBar = self.navigationController?.navigationBar {
            let gradient = CAGradientLayer()
            var bounds = navigationBar.bounds
            bounds.size.height += UIApplication.shared.statusBarFrame.size.height
            gradient.frame = bounds
            gradient.colors = [UIColor(hex: "#02D6F0", alpha: 1.0).cgColor,
            UIColor(hex: "#02C3E7", alpha: 1.0).cgColor,
            UIColor(hex: "#01ADDD", alpha: 1.0).cgColor]
            gradient.startPoint = CGPoint(x: 0, y: 0)
            gradient.endPoint = CGPoint(x: 0, y: 1)
            
            if let image = getImageFrom(gradientLayer: gradient) {
                navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            }
        }
    }
    
    private func setLayout() {
        smallCircle.roundCorners(corners: .allCorners, radius: 14)
        smallCircle.backgroundColor = UIColor(hex: "#ffffff", alpha: 0.2)
        largeCircle.roundCorners(corners: .allCorners, radius: 32)
        largeCircle.backgroundColor = UIColor(hex: "#ffffff", alpha: 0.2)
        
        topSection.frame.size.width = self.view.bounds.width
        
        let deptName = "컴퓨터학부"
        lblDeptName.text = deptName.replacingOccurrences(of: " ", with: "\n")
        
        if deptName.split(separator: " ").count > 1 {
            lblDeptName.font = UIFont(name: lblDeptName.font.fontName, size: 27)
            lblDeptNameHeight.constant = 60
            
            topBackgroundSectionHeight.constant = 226
            topSection.frame.size.height = 226
            topSectionHeight.constant = 248
        } else {
            lblDeptName.font = UIFont(name: lblDeptName.font.fontName, size: 32)
            lblDeptNameHeight.constant = 28
            
            topBackgroundSectionHeight.constant = 193
            topSection.frame.size.height = 193
            topSectionHeight.constant = 215
        }
        
        topSection.setGradientBackground(colors: [UIColor(hex: "#02D6F0", alpha: 1.0).cgColor,
                                                  UIColor(hex: "#02C3E7", alpha: 1.0).cgColor,
                                                  UIColor(hex: "#01ADDD", alpha: 1.0).cgColor])
        topSection.roundCorners(corners: [.bottomLeft, .bottomRight], radius: 50)
        
        searchSection.layer.cornerRadius = 22
        searchSection.layer.borderColor = UIColor(hex: "#c5dbf1", alpha: 1.0).cgColor
        searchSection.layer.borderWidth = 1.5
        
        tfSearchKeyword.textColor = UIColor(hex: "#d0d0d0", alpha: 1.0)
        tfSearchKeyword.placeholder = "내가 찾고싶은 공지"
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.isEnabled = true
        tapGestureRecognizer.cancelsTouchesInView = false
        scrollViewMyNotice.addGestureRecognizer(tapGestureRecognizer)
        
        topSection.backgroundColor = .blue
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("View Touch!")
        self.view.endEditing(true)
    }
    
    @objc func dismissKeyboard(sender: UITapGestureRecognizer) {
        print("Scroll View Touch!")
        self.view.endEditing(true)
    }
}
