//
//  MyDJViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit

class MyDJViewController: BaseViewController {

    private let selfView = MydjView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self 
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        
        selfView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }
    
    

}
