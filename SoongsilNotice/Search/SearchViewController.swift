//
//  SearchViewController.swift
//  SoongsilNotice
//
//  Created by TaeinKim on 2019/11/19.
//  Copyright © 2019 TaeinKim. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, SearchViewProtocol, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var majorText         : UILabel!
    @IBOutlet weak var lblSelectedMajor  : UILabel!
    @IBOutlet weak var pickerView        : UIPickerView!
    @IBOutlet weak var searchBtn         : UIButton!
    @IBOutlet weak var majorSelectionBtn: UIButton!
    @IBOutlet weak var keywordTextField  : UITextField!
    
    private var presenter: SearchPresenter!
    
    private var selectedIndex = -1
    private var selectedMajor = DeptName.IT_Computer
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = SearchPresenter(view: self)
        
        self.keywordTextField.layer.borderWidth = 0.5
        self.keywordTextField.layer.borderColor = UIColor.SUB200.cgColor
        
        self.lblSelectedMajor.textColor = UIColor.MONO300
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Appear")
        self.navigationItem.title = "검색"
        self.navigationController?.navigationBar.topItem?.title = "검색"
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func searchAction(_ sender: Any?) {
        print("검색 : \(String(describing: self.keywordTextField.text))")
        
        if selectedIndex < 0 {
            let alert = UIAlertController(title: "전공을 선택해주세요", message: "", preferredStyle: .alert)
            alert.isModalInPopover = true
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert,animated: true, completion: nil )
        } else if (self.keywordTextField.text ?? "").isEmpty {
            let alert = UIAlertController(title: "검색어를 입력해주세요", message: "", preferredStyle: .alert)
            alert.isModalInPopover = true
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
            self.present(alert,animated: true, completion: nil )
        } else {
            
            let storyBoard = self.storyboard!
            let noticeListViewController = storyBoard.instantiateViewController(withIdentifier: "noticeListVC") as? NoticeListViewController
            
            noticeListViewController?.department = Major(majorCode: self.presenter.getMajorCodeListItem(at: selectedIndex), majorName: selectedMajor, majorNameEng: nil)
            
            noticeListViewController?.isSearchResult = true
            noticeListViewController?.listType = .normalList
            noticeListViewController?.searchKeyword = self.keywordTextField.text
            
            self.navigationController?.pushViewController(noticeListViewController!, animated: true)
        }
    }
    
    @IBAction func selectMajorAction(_ sender: Any?) {
        showPickerActionSheet()
    }
    
    func showPickerActionSheet() {
        let alert: UIAlertController?
        let pickerFrame: UIPickerView?
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            alert = UIAlertController(title: "전공을 선택하세요.", message: "\n\n\n\n\n\n\n\n", preferredStyle: .alert)
            alert!.isModalInPopover = true
            pickerFrame = UIPickerView(frame: CGRect(x: 0, y: 40, width: 270, height: 150))
        } else {
            alert = UIAlertController(title: "전공을 선택하세요.", message: "\n\n\n\n\n\n", preferredStyle: .actionSheet)
            alert!.isModalInPopover = true
            let width = alert!.view.frame.width
            pickerFrame = UIPickerView(frame: CGRect(x: 0, y: 40, width: width - 16, height: 150))
        }
        
        alert!.view.addSubview(pickerFrame!)
        pickerFrame!.dataSource = self
        pickerFrame!.delegate = self
        
        if self.selectedIndex < 0 {
            self.selectedIndex = 0
        }
        
        pickerFrame!.selectRow(selectedIndex, inComponent: 0, animated: true)
        
        alert!.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        alert!.addAction(UIAlertAction(title: "확인", style: .default, handler: { (UIAlertAction) in
            self.lblSelectedMajor.text = "선택한 전공 : \(self.selectedMajor.rawValue)"
            
        }))
        self.present(alert!, animated: true, completion: nil)
    }
    
}

extension SearchViewController {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.presenter.getMajorCodeListCount()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.presenter.getMajorListItem(at: row).rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("\(row) : \(self.presenter.getMajorListItem(at: row))")
        selectedIndex = row
        selectedMajor = self.presenter.getMajorListItem(at: row)
    }
}
