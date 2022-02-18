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
        
        LoginAPI.signUp(request: .init(email: "test2@email.com", nickname: "12345", password: "12345678")) { response in
            switch response {
            case .success(let data):
                
                print(data)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
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
                guard let text = self?.topView.nickNameField.text else { return }
                if text.count > 12 {
                    self?.topView.nickNameField.layer.borderWidth = 1
                    self?.topView.nickNameField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                    self?.topView.nickNameLabel.warningLabel.text = "닉네임은 12자리 이하로 해주세요."
                    self?.topView.nickNameLabel.warningLabel.isHidden = false
                } else if (self?.viewModel.hasSameName())! {
                    self?.topView.nickNameField.layer.borderWidth = 1
                    self?.topView.nickNameField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                    self?.topView.nickNameLabel.warningLabel.text = "이미 쓰고 있는 닉네임 이에요."
                    self?.topView.nickNameLabel.warningLabel.isHidden = false
                } else {
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc,animated: true)
                }
                
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
        
        let privateSubject = button1.rx.tap
            .scan(false) { [weak self] prev, new in
                self?.viewModel.isChecked(button1)
                return !prev
            }
        
        let useSubject = button2.rx.tap
            .scan(false) { [weak self] prev, new in
                self?.viewModel.isChecked(button2)
                return !prev
            }
        
        let nickNameSubject = topView.nickNameField.rx.text
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { text -> Bool in
                return !(text?.isEmpty ?? true)
            }.distinctUntilChanged()
        
        Observable.combineLatest(privateSubject, useSubject, nickNameSubject)
        { $0 && $1 && $2 }
        .withUnretained(self)
        .subscribe(onNext: { owner,info in
            if info {
                owner.nextButton.backgroundColor = .mainOrange
                owner.nextButton.setTitleColor(.white, for: .normal)
                owner.nextButton.isEnabled = true
            } else {
                owner.nextButton.backgroundColor = .mainGrey4
                owner.nextButton.setTitleColor(.mainGrey7, for: .normal)
                owner.nextButton.isEnabled = false
            }
        }).disposed(by: disposeBag)
        
        nickNameSubject
            .withUnretained(self)
            .subscribe(onNext: { owner,info in
                if !info {
                    owner.topView.nickNameField.layer.borderWidth = 0
                    owner.topView.nickNameLabel.warningLabel.isHidden = true
                }
            }).disposed(by: disposeBag)
        
    }
}

