//
//  CategoryViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CategoryViewController:BaseViewController {
    
    private let selfView = CategoryView()
   
    
//    init(viewModel:CreateViewModel) {
//        self.viewModel = viewModel
//        super.init(nibName: nil, bundle: nil)
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview().inset(16)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        
    }
}
