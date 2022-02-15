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

class LoginViewController:UIViewController {
    
    private let disposeBag = DisposeBag()
    private let viewModel = LoginVeiwModel()
    private let topView = LoginTopView()
    private let bottomView = ButtonView()
    var passwordFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBackGround
        topView.coverView.backButton.isHidden = true
        bind()
        dismissKeyboardWhenTappedAround()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureUI()
    }
    
    func configureUI() {
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        topView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.height.equalToSuperview().multipliedBy(Constant.LoginTopViewHeight)
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
        let isEmailEmpty = topView.passwordField.rx.text
             .throttle(RxTimeInterval.milliseconds(1), scheduler: MainScheduler.instance)
             .map { text -> Bool in
                 return !(text?.isEmpty ?? true)
             }.distinctUntilChanged()
        
        
        let isPassWordEmpty = topView.passwordField.rx.text
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { text -> Bool in
                return !(text?.isEmpty ?? true)
            }.distinctUntilChanged()
        
        Observable.combineLatest(isEmailEmpty, isPassWordEmpty)
            .map { $0 && $1 }
            .distinctUntilChanged()
            .withUnretained(self)
            .subscribe(onNext: { owner,info in
                if info {
                    owner.bottomView.loginButton.backgroundColor = .mainOrange
                    owner.bottomView.loginButton.setTitleColor(.white, for: .normal)
                    owner.bottomView.loginButton.isEnabled = true
                } else  {
                    owner.bottomView.loginButton.backgroundColor = .mainGrey4
                    owner.bottomView.loginButton.setTitleColor(.mainGrey7, for: .normal)
                    owner.bottomView.loginButton.isEnabled = false
                }
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
        
        
        topView.labelsView.signUpButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                let vc = SignUpViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc,animated:false)
            }).disposed(by: disposeBag)
        
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

