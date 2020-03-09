//
//  ManualViewController.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/20.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import Foundation
import UIKit

class ManualViewController : BaseViewController {
    
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var startButton: UIButton!
    
    let manualImageList = [UIImage(named: "manual_0"), UIImage(named: "manual_1"), UIImage(named: "manual_2"), UIImage(named: "manual_3"), UIImage(named: "manual_4"), UIImage(named: "manual_5")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startButton.isHidden = true
        self.startButton.layer.masksToBounds = true
        self.startButton.layer.cornerRadius = 4
        
        for index in 0..<manualImageList.count {
            let subView = UIImageView()
            subView.frame = UIScreen.main.bounds
            subView.image = manualImageList[index]
            subView.contentMode = .scaleToFill
            
            subView.frame.origin.x = UIScreen.main.bounds.width * CGFloat(index)
            self.scrollView.addSubview(subView)
        }
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(manualImageList.count),
            height: UIScreen.main.bounds.height
        )
        scrollView.alwaysBounceVertical = false
        pageControl.numberOfPages = manualImageList.count
        
    }
    
    @IBAction func onClickStartButton(_ sender: Any?) {
        HomeSwitcher.updateRootVC()
    }
}


extension ManualViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int(floor(scrollView.contentOffset.x / UIScreen.main.bounds.width))
        
        if pageControl?.currentPage == (manualImageList.count - 1) {
            self.startButton.isHidden = false
        } else {
            self.startButton.isHidden = true
        }
    }
}
