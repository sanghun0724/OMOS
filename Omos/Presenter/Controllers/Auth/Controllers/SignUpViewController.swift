//
//  SignUpViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/12.
//

import UIKit


class SignUpViewController:BaseViewController {
    
    let topView = CoverView()
    let bottomView = SignUpView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureUI() {
        topView.titleLabel.text = "회원가입"
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(Constant.LoginTopViewHeight)
        }
        bottomView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topView.snp.bottom)
            make.height.equalTo(300)
        }
    }
}
