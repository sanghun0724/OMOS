//
//  CreateViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/20.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class CreateViewController:BaseViewController {
    
    private let selfView = CreateView()
    let viewModel:CreateViewModel
    
    init(viewModel:CreateViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        super.configureUI()
        self.view.addSubview(selfView)
        
        selfView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
        
    }
}
