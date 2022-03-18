//
//  ProfileViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    private let selfView = ProfileView()

    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.backgroundColor = .mainBlack
        self.tabBarController?.tabBar.isHidden = false 
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.backgroundColor = .mainBackGround
    }
    
    override func configureUI() {
        self.view.backgroundColor = .mainBlack
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        view.addSubview(selfView)
        selfView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
