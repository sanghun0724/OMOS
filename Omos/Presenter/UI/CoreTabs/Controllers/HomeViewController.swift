//
//  HomeViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController:BaseViewController {
    
    let selfView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.dataSource = self
        selfView.tableView.delegate = self
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}

