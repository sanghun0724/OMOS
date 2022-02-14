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
        print("profile")
    }
    
    override func configureUI() {
        view.addSubview(selfView)
        selfView.frame = view.bounds
    }
}
