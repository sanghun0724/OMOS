//
//  SettingViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import UIKit

class SettingViewController:BaseViewController {
    
    let tableView:UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "header")
        table.separatorStyle = .none
        table.backgroundColor = .mainBackGround
        table.showsVerticalScrollIndicator = false
        table.isScrollEnabled = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.view.backgroundColor = .mainBackGround
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true 
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}


extension SettingViewController:UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .mainBackGround
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "프로필 변경"
            case 1:
                cell.textLabel?.text = "비밀번호 변경"
            default:
                print("")
            }
        } else {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "로그아웃"
            case 1:
                cell.textLabel?.text = "계정탈퇴"
            default:
                print("")
            }
        }
        
    
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")!
        if section == 0 {
            header.textLabel?.text = "개인정보"
        } else {
            header.textLabel?.text = "계정관리"
        }
        return header
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let view = view as? UITableViewHeaderFooterView {
            view.backgroundView?.backgroundColor = .mainBackGround
            view.textLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
            view.textLabel?.textColor = .mainOrange
          }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
               let vc = ProfileChangeViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            case 1:
                let vc = PasswordChangeViewController()
                 self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("")
            }
        } else {
            switch indexPath.row {
            case 0:
                //logout
                let action = UIAlertAction(title: "로그아웃", style: .default) { alert in
                    print(alert)
                }
                action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                self.presentAlert(title: "", message: "정말 로그아웃 하시겠어요?", isCancelActionIncluded: true, preferredStyle: .alert, with: action)
            case 1:
                let vc = AccountOutViewController()
                 self.navigationController?.pushViewController(vc, animated: true)
            default:
                print("")
            }
        }
        
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       let view = UIView()
        view.backgroundColor = .mainBlack1
       return view
   }

   public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       if section == 0 {
           return 0.5
       } else {
           return 0
       }
       
   }
    
}
