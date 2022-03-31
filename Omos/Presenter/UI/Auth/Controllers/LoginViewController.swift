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
    private let viewModel:LoginViewModel
    private let topView = LoginTopView()
    private let bottomView = ButtonView()
    var passwordFlag = false
    
    init(viewModel:LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .mainBackGround
        topView.coverView.backButton.isHidden = true
        bind()
        dismissKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(didRecieveLoginNotification), name: NSNotification.Name.loginInfo, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        configureUI()
    }
    
    @objc func didRecieveLoginNotification() {
        let action = UIAlertAction(title: "완료", style: .default) { alert in
            
        }
        action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
        self.presentAlert(title: "", message: "회원가입이 완료되었습니다.\n다시 로그인 해주세요.", isCancelActionIncluded: false, preferredStyle: .alert, with: action)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    private func bind() {
        
        let isEmailEmpty = topView.emailField.rx.text
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { text -> Bool in
                return !(text?.isEmpty ?? true)
            }.distinctUntilChanged()
            
        isEmailEmpty
            .withUnretained(self)
            .subscribe(onNext: { owner,info in
                if !info {
                    owner.topView.emailField.layer.borderWidth = 0
                    owner.topView.emailLabel.warningLabel.isHidden = true
                }
            }).disposed(by: disposeBag)
        
        let isPassWordEmpty = topView.passwordField.rx.text
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { text -> Bool in
                return !(text?.isEmpty ?? true)
            }.distinctUntilChanged()
        
        Observable.combineLatest(isEmailEmpty, isPassWordEmpty)
        { $0 && $1 }
        .withUnretained(self)
        .subscribe(onNext: { owner,info in
            if info {
                owner.bottomView.loginButton.backgroundColor = .mainOrange
                owner.bottomView.loginButton.setTitleColor(.white, for: .normal)
                owner.bottomView.loginButton.isEnabled = true
            } else {
                owner.bottomView.loginButton.backgroundColor = .mainGrey4
                owner.bottomView.loginButton.setTitleColor(.mainGrey7, for: .normal)
                owner.bottomView.loginButton.isEnabled = false
            }
        }).disposed(by: disposeBag)
        
        isPassWordEmpty
            .withUnretained(self)
            .subscribe(onNext: { owner,info in
                if !info {
                    owner.topView.passwordField.layer.borderWidth = 0
                    owner.topView.passwordLabel.warningLabel.isHidden = true
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
                let rp = AuthRepositoryImpl(loginAPI: LoginAPI())
                let uc = LoginUseCase(authRepository: rp)
                let vm = SignUpViewModel(usecase: uc)
                let vc = SignUpViewController(viewModel: vm)
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc,animated:false)
            }).disposed(by: disposeBag)
        
        //BottomView
        bottomView.loginButton.rx
            .tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.loginLocal(email: (self?.topView.emailField.text)!, password: (self?.topView.passwordField.text)!)
            }).disposed(by: disposeBag)
        
        viewModel.validSignIn.subscribe(onNext: { [weak self] valid in
            if valid {
                print(UserDefaults.standard.integer(forKey: "user"))
                let vc = TabBarViewController()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc,animated: true)
            } else {
                self?.topView.emailField.layer.borderWidth = 1
                self?.topView.emailField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                self?.topView.emailLabel.warningLabel.text = "입력하신 내용을 다시 확인해주세요."
                self?.topView.emailLabel.warningLabel.isHidden = false
                self?.topView.passwordField.layer.borderWidth = 1
                self?.topView.passwordField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                self?.topView.passwordLabel.warningLabel.text = "입력하신 내용을 다시 확인해주세요."
                self?.topView.passwordLabel.warningLabel.isHidden = false
            }
        }).disposed(by: disposeBag)
        
        
        bottomView.kakaoButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.viewModel.loginKakao()
                self?.viewModel.hasKakaoEmail.subscribe(onNext: { [weak self] valid in
                    if valid {
                        let vc = TabBarViewController()
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc,animated: true)
                    } else {
                        let rp = AuthRepositoryImpl(loginAPI: LoginAPI())
                        let uc = LoginUseCase(authRepository: rp)
                        let vm = SignUpViewModel(usecase: uc)
                        let vc = NickNameViewController(viewModel: vm)
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc,animated: true)
                    }
                }).disposed(by: self!.disposeBag)
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
            UserDefaults.standard.set(user, forKey: "appleUser")
            let email = credential.email
            print("email:\(email)")
            UserDefaults.standard.set(email ?? "" + "apple", forKey: "appleEmail")
            
            //앱 삭제후 다시 들어가면 위의 유저값만 받아올수 있으니 유저값이 서버에 있으면 다시 로그인 되는 로직들 필요 
            
            let appleEmail = UserDefaults.standard.string(forKey: "appleEmail")
            
            LoginAPI.SNSLogin(request: .init(email:appleEmail ?? "" , type: .APPLE)) { [weak self] result in
                switch result {
                case .success(let token):
                    UserDefaults.standard.set(token.accessToken, forKey: "access")
                    UserDefaults.standard.set(token.refreshToken, forKey: "refresh")
                    UserDefaults.standard.set(token.userId, forKey: "user")
                    Account.currentUser = UserDefaults.standard.integer(forKey: "user")
                    let vc = TabBarViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc,animated: true)
                case .failure:
                    let rp = AuthRepositoryImpl(loginAPI: LoginAPI())
                    let uc = LoginUseCase(authRepository: rp)
                    let vm = SignUpViewModel(usecase: uc)
                    let vc = NickNameViewController(viewModel: vm)
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc,animated: true)
                }
            }
            
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login Error:\(error.localizedDescription)")
    }
}

