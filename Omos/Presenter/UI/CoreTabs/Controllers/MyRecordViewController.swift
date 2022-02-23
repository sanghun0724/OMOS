//
//  MyRecordViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit

class MyRecordViewController: BaseViewController {
    
    private let selfView = MyRecordView()
    let viewModel:MyRecordViewModel
    
    init(viewModel:MyRecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        configureUI()
    }
    
    override func configureUI() {
        view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
    }

   

}
