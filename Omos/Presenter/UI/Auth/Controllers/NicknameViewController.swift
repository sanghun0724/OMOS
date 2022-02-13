//
//  NicknameViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/12.
//

import UIKit
import RxSwift
import RxCocoa

class NickNameViewController:BaseViewController {
    
    private let topView = NickNameView()
    
    private let nextButton:UIButton = {
       let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.backgroundColor = .mainGrey4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func configureUI() {
        view.addSubview(topView)
        view.addSubview(nextButton)
        
        topView.coverView.titleLabel.text = "회원가입"
        topView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalToSuperview().multipliedBy(Constant.LoginTopViewHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.06)
            make.bottom.equalToSuperview().offset(-40)
        }
        
    }
    
    private func bind() {
        
        nextButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc,animated: true)
            }).disposed(by: disposeBag)
        
    }
    
    
}

