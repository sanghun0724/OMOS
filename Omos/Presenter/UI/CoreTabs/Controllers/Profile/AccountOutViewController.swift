//
//  AccountOutViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/19.
//

import Foundation
import KakaoSDKAuth
import KakaoSDKCommon
import KakaoSDKUser
import UIKit

class AccountOutViewController: BaseViewController {
    let selfView = AccountOutView()
    let viewModel: ProfileViewModel
    
    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
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
                UserApi.shared.logout {error in
                    if let error = error {
                        print(error)
                    } else {
                        print("로그아웃 성공")
                    }
                }
                self?.resetDefaults()
                self?.viewModel.signOut(userId: Account.currentUser)
            }).disposed(by: disposeBag)
        
        viewModel.signoutState
            .subscribe(onNext: { [weak self] state in
                if state {
                    let uc = LoginUseCase(authRepository: AuthRepositoryImpl(loginAPI: LoginAPI()))
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
