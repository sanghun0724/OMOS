//
//  SignUpViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/12.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController:UIViewController {
    
    private let disposeBag = DisposeBag()
    private let topView = SignUpView()
    
    private let nextButton:UIButton = {
       let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .mainGrey4
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        configureUI()
    }
    
    func configureUI() {
        topView.coverView.titleLabel.text = "회원가입"
        view.addSubview(topView)
        view.addSubview(nextButton)
        
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
    
    func bind() {
        
        topView.coverView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: false, completion: nil)
                print("back")
            }).disposed(by: disposeBag)
        
        nextButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                let vc = NickNameViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc,animated: false)
            }).disposed(by: disposeBag)
    }
}
