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

        self.navigationController?.navigationBar.backgroundColor = .mainBlack
    }
    
    override func configureUI() {
        self.view.backgroundColor = .mainBlack
        view.addSubview(selfView)
        selfView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
