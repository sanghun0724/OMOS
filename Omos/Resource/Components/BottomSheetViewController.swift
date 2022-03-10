//
//  BottomSheetViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/09.
//

import Foundation
import UIKit
import MaterialComponents.MaterialBottomSheet

enum SheetType {
    case MyRecord
    case AllRecord
}

class BottomSheetViewController:UIViewController {
    
    let type:SheetType
    let myRecordVM:MyRecordDetailViewModel?
    let AllRecordVM:AllRecordViewModel?
    
    init(type:SheetType,myRecordVM:MyRecordDetailViewModel?,AllRecordVM:AllRecordViewModel?) {
        self.type = type
        self.myRecordVM = myRecordVM
        self.AllRecordVM = AllRecordVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView:UITableView = {
        let table = UITableView()
      
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.addSubview(tableView)
        tableView.backgroundColor = .clear
        tableView.frame = view.bounds
        tableView.tableHeaderView = UIView(frame:CGRect(x: 0, y: 0, width: tableView.contentSize.width, height: CGFloat.leastNormalMagnitude))
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
    }
    
}

extension BottomSheetViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
        cell.backgroundColor = .mainBackGround
        if type == .MyRecord {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "삭제"
            case 1:
                cell.textLabel?.text = "수정"
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                cell.directionalLayoutMargins = .zero
            default:
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                cell.directionalLayoutMargins = .zero
            }
         
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constant.mainHeight * 0.067
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        dismiss(animated: true)
        if type == .MyRecord {
            switch indexPath.row {
            case 0:
                myRecordVM?.delete.onNext(true)
                UserDefaults.standard.set(1, forKey: "reload")
            case 1:
                myRecordVM?.modify.onNext(true)
            default:
                print("defualt")
            }
        }
    }
    
}
