//
//  LoginViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/05.
//

import UIKit
import SnapKit
import AuthenticationServices

import RxSwift
import RxCocoa

class LoginViewController:BaseViewController {
    
    private let viewModel = LoginVeiwModel()
    private let topView = LoginView()
    private let bottomView = ButtonView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBackGround
    }
    
    override func configureUI() {
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        topView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.6)
          }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.left.right.equalToSuperview().inset(22)
            make.bottom.equalToSuperview().inset(40)
        }
    }
    
    private func bind() {
        
        //TopView
//        topView.emailField.rx.text
//            .map{ $0 ?? ""}
//            .
        
        
        //BottomView
        bottomView.loginButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.loginLocal()
            }).disposed(by: disposeBag)
        
        bottomView.kakaoButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.loginKakao()
            }).disposed(by: disposeBag)
        
        bottomView.appleButton.addTarget(self, action: #selector(loginApple), for: .touchUpInside)
        
        
        
    }
    
    
    //MARK: APPLE LOGIN
    @objc func loginApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName,.email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
}

//Apple
extension LoginViewController:ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = credential.user
            print("user:\(user)")
            if let email = credential.email {
                print("email:\(email)")
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login Error:\(error.localizedDescription)")
    }
}


//Kakao
extension LoginViewController {
   
}
