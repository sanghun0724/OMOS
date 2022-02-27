//
//  MydjProfileViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/27.
//

import UIKit

class MydjProfileViewController:BaseViewController {
    
    private let selfView = MydjProfieView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        self.navigationItem.rightBarButtonItems?.removeAll()
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
        
        
    }
    
}
