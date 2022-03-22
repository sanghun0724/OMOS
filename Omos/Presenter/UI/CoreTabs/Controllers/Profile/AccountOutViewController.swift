//
//  AccountOutViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/19.
//

import Foundation
import UIKit
import KakaoSDKUser
import KakaoSDKCommon
import KakaoSDKAuth


class AccountOutViewController:BaseViewController {
    
    let selfView = AccountOutView()
    let viewModel:ProfileViewModel
    
    init(viewModel:ProfileViewModel) {
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
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
    }
    
    
    
    func bind() {
        
        selfView.buttonView.rx.tap
            .subscribe(onNext: { [weak self] _ in
                UserApi.shared.logout {(error) in
                    if let error = error {
                        print(error)
                    }
                    else {
                        print("로그아웃 성공")
                    }
                }
                self?.resetDefaults()
                self?.viewModel.signOut(userId: Account.currentUser)
                
            }).disposed(by: disposeBag)
        
        viewModel.signoutState
            .subscribe(onNext: { [weak self] state in
                if state {
                    let uc = LoginUseCase(authRepository:AuthRepositoryImpl(loginAPI: LoginAPI()))
                    let vm = LoginViewModel(usecase: uc)
                    let vc = LoginViewController(viewModel: vm)
                    UIApplication.shared.windows.first?.rootViewController = vc
                    UIApplication.shared.windows.first?.makeKeyAndVisible()
                    self?.navigationController?.popToRootViewController(animated: false)
                }
            }).disposed(by: disposeBag)
    }
    
    private func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}

class AccountOutView:BaseView {
    
    let topLabel:UILabel = {
        let label = UILabel()
        label.text = "OOO님과 \n이별인가요? 너무 아쉬워요... "
        label.textColor = .mainOrange
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    let bottomLabel:UILabel = {
        let label = UILabel()
        label.text = "계정을 삭제하면 MY 레코드, 공감, 스크랩 등 모든 활동\n정보가 삭제됩니다. 다음에 다시 만날 수 있길 바라요!"
        label.font = .systemFont(ofSize: 16, weight: .light)
        label.numberOfLines = 2
        return label
    }()
    
    let buttonView:UIButton = {
       let button = UIButton()
        button.backgroundColor = .mainGrey4
        button.setTitle("탈퇴하기", for: .normal)
        button.setTitleColor(.mainGrey7, for: .normal)
        return button
    }()
    
    
    override func configureUI() {
        super.configureUI()
        self.addSubview(topLabel)
        self.addSubview(bottomLabel)
        self.addSubview(buttonView)
        
        topLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(24)
            topLabel.sizeToFit()
        }
        
        bottomLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(topLabel.snp.bottom).offset(16)
            bottomLabel.sizeToFit()
        }
        
        buttonView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(bottomLabel)
            make.height.equalToSuperview().multipliedBy(0.07)
            make.bottom.equalToSuperview().offset(-34)
        }
        
        
        
        
        
        
    }
    
    
}
