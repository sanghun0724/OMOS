//
//  AllRecordViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit
import SnapKit

class AllRecordViewController: BaseViewController {

    let viewModel:AllRecordViewModel
    
    init(viewModel:AllRecordViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let selfView = AllRecordView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selfView.tableView.delegate = self
        selfView.tableView.dataSource = self
        
    }
    
    override func configureUI() {
        
        view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
}
