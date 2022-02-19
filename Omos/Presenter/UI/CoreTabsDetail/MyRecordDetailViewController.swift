//
//  MyRecordDetailViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/19.
//

import UIKit

class MyRecordDetailViewController:BaseViewController {
    
    private let selfView = MyRecordDetailView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    override func configureUI() {
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
    }
    
    
}
