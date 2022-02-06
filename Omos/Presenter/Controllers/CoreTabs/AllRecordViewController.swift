//
//  AllRecordViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import UIKit
import SnapKit

class AllRecordViewController: BaseViewController {

    
    
    private let selfView = AllRecordView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    override func configureUI() {
        
        view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    
}
