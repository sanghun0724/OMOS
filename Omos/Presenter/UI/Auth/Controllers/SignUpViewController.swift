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
    var passwordFlag = false
    
    private let nextButton:UIButton = {
       let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .mainGrey4
        button.setTitleColor(.mainGrey7, for: .normal)
        button.layer.cornerRadius = Constant.loginCorner
        button.layer.masksToBounds = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTappedAround()
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
        
        topView.passwordDecoView.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                if !(self?.passwordFlag)! {
                    self?.topView.passwordField.isSecureTextEntry = false
                    self?.topView.passwordDecoView.setImage(UIImage(named: "visible1" ), for: .normal)
                        self?.passwordFlag = true
                } else {
                    self?.topView.passwordField.isSecureTextEntry = true
                    self?.topView.passwordDecoView.setImage(UIImage(named: "visible2" ), for: .normal)
                    self?.passwordFlag = false
                }
            }).disposed(by: disposeBag)
        
        topView.repasswordDecoView.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                if !(self?.passwordFlag)! {
                    self?.topView.repasswordField.isSecureTextEntry = false
                    self?.topView.repasswordDecoView.setImage(UIImage(named: "visible1" ), for: .normal)
                        self?.passwordFlag = true
                } else {
                    self?.topView.repasswordField.isSecureTextEntry = true
                    self?.topView.repasswordDecoView.setImage(UIImage(named: "visible2" ), for: .normal)
                    self?.passwordFlag = false
                }
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
