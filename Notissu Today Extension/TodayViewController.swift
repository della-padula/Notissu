//
//  TodayViewController.swift
//  Notissu Today Extension
//
//  Created by TaeinKim on 2020/01/26.
//  Copyright © 2020 TaeinKim. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet var DebugText: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let myDeptNameRawValue = UserDefaults(suiteName: "group.com.elliott.Notissu")?.string(forKey: "myDeptName")
        let myDeptCodeRawValue = UserDefaults(suiteName: "group.com.elliott.Notissu")?.integer(forKey: "myDeptCode")
        
        self.DebugText.text = "[name_raw] : \(myDeptNameRawValue)\n[code_raw] : \(myDeptCodeRawValue)"
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
