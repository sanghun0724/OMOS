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
    
    private let viewModel = LoginVeiwModel()
    private let topView = NickNameView()
    
    private let nextButton:UIButton = {
       let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.backgroundColor = .mainGrey4
        button.setTitleColor(.mainGrey7, for: .normal)
        button.layer.cornerRadius = Constant.loginCorner
        button.layer.masksToBounds = true
        button.isEnabled = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTappedAround()
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
        
        topView.coverView.backButton.rx.tap
            .asDriver()
            .drive(onNext:{ [weak self] in
                self?.dismiss(animated: false, completion: nil)
            }).disposed(by: disposeBag)
        
        topView.privateLabel1.subButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
               let vc = InfoController()
                vc.getInfoView(file: "UseInfoText")
                self?.present(vc,animated: true)
            }).disposed(by: disposeBag)
        
        topView.privateLabel2.subButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
               let vc = InfoController()
                vc.getInfoView(file: "PrivateInfoText")
                self?.present(vc,animated: true)
            }).disposed(by: disposeBag)
        
        let button1 = self.topView.privateLabel1.checkButton
        let button2 = self.topView.privateLabel2.checkButton
        topView.privateLabel1.checkButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.isChecked(button1)
                self?.viewModel.isAllChecked(button1, button2)
            }).disposed(by: disposeBag)
        
        topView.privateLabel2.checkButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.isChecked(button2)
                self?.viewModel.isAllChecked(button1, button2)
            }).disposed(by: disposeBag)
        
        viewModel.ischeckedSubject
            .withUnretained(self)
            .subscribe(onNext: { owner,info in
                if info == true  {
                    owner.nextButton.backgroundColor = .mainOrange
                    owner.nextButton.titleLabel?.textColor = .white
                    owner.nextButton.isEnabled = true
                } else  {
                    owner.nextButton.backgroundColor = .mainGrey4
                    owner.nextButton.titleLabel?.textColor = .mainGrey7
                    owner.nextButton.isEnabled = false
                }
            }).disposed(by: disposeBag)
        
    }
}

