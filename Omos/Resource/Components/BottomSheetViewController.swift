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
    case AllcateRecord
    case searchTrack
}

class BottomSheetViewController:UIViewController {
    
    let type:SheetType
    let myRecordVM:MyRecordDetailViewModel?
    let allRecordVM:AllRecordCateDetailViewModel?
    let searchTrackVM:AllRecordSearchDetailViewModel?
    
    init(type:SheetType,myRecordVM:MyRecordDetailViewModel?,allRecordVM:AllRecordCateDetailViewModel?,searchTrackVM:AllRecordSearchDetailViewModel?) {
        self.type = type
        self.myRecordVM = myRecordVM
        self.allRecordVM = allRecordVM
        self.searchTrackVM = searchTrackVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let tableView:UITableView = {
        let table = UITableView()
      
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(filterCell.self, forCellReuseIdentifier: filterCell.identifier)
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
        if type == .MyRecord {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UITableViewCell
            cell.backgroundColor = .mainBackGround
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
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: filterCell.identifier, for: indexPath) as! filterCell
            cell.backgroundColor = .mainBackGround
            cell.checkImageView.isHidden = true
            switch indexPath.row {
            case 0:
                cell.filterLabel.text = "최신순"
            case 1:
                cell.filterLabel.text = "공감순"
            case 2:
                cell.filterLabel.text = "랜덤순"
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                cell.directionalLayoutMargins = .zero
            default:
                cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
                cell.directionalLayoutMargins = .zero
            }
            return cell
        }
        
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
        } else if type == .AllcateRecord {
            switch indexPath.row {
            case 0:
                allRecordVM?.recentFilter.onNext(true)
            case 1:
                allRecordVM?.likeFilter.onNext(true)
            case 2:
                allRecordVM?.randomFilter.onNext(true)
            default:
                print("defualt")
            }
        } else {
            switch indexPath.row {
            case 0:
                searchTrackVM?.recentFilter.onNext(true)
            case 1:
                searchTrackVM?.likeFilter.onNext(true)
            case 2:
                searchTrackVM?.randomFilter.onNext(true)
            default:
                print("defualt")
            }
        }
    }
    
}



class filterCell:UITableViewCell {
    static let identifier = "filterCell"
    
    
    let filterLabel:UILabel = {
        let label = UILabel()
        return label
    }()
    
    let checkImageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "check"))
        return imageView
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureUI()
    }
    
    func configureUI() {
        self.addSubview(filterLabel)
        self.addSubview(checkImageView)
        
        filterLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            filterLabel.sizeToFit()
        }
        
        checkImageView.snp.makeConstraints { make in
            make.leading.equalTo(filterLabel.snp.trailing).offset(8)
            make.height.equalTo(filterLabel)
            make.width.equalTo(checkImageView.snp.height)
            make.centerY.equalToSuperview()
        }
        
    }
    
    
    
    
    
    
}
