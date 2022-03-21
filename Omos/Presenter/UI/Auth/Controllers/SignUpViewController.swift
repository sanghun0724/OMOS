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
    
    private let viewModel:SignUpViewModel
    private let disposeBag = DisposeBag()
    private let topView = SignUpView()
    var passwordFlag = false
    
    init(viewModel:SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
                guard let text1 = self?.topView.emailField.text else { return }
                guard let text2 = self?.topView.passwordField.text else { return }
                guard let text3 = self?.topView.repasswordField.text else { return }
                self?.viewModel.hasSameName(email: text1)
                //밑에거 따로빼서 zip으로 묶어주자
                self?.viewModel.validEmail.subscribe(onNext: { [weak self] valid in
                    if !(text1.validateEmail()) {
                        self?.topView.emailField.layer.borderWidth = 1
                        self?.topView.emailField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                        self?.topView.emailLabel.warningLabel.text = "올바른 이메일 형식이 아니에요."
                        self?.topView.emailLabel.warningLabel.isHidden = false
                    } else if !valid {
                        self?.topView.emailField.layer.borderWidth = 1
                        self?.topView.emailField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                        self?.topView.emailLabel.warningLabel.text = "중복된 이메일이 존재해요."
                        self?.topView.emailLabel.warningLabel.isHidden = false
                    } else {
                        self?.topView.emailField.layer.borderWidth = 0
                        self?.topView.emailLabel.warningLabel.isHidden = true
                    }
                    if !(text2.count >= 8 && text2.count <= 16 && !(text2.hasCharacters())) {
                        self?.topView.passwordField.layer.borderWidth = 1
                        self?.topView.passwordField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                        self?.topView.passwordLabel.warningLabel.text = "8~16자의 영문 대소문자,숫자,특수문자만 가능해요"
                        self?.topView.passwordLabel.warningLabel.isHidden = false
                    } else {
                        self?.topView.passwordField.layer.borderWidth = 0
                        self?.topView.passwordLabel.warningLabel.isHidden = true
                    }
                    
                    if !(text3 == text2) {
                        self?.topView.repasswordField.layer.borderWidth = 1
                        self?.topView.repasswordField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                        self?.topView.repaswwordLabel.warningLabel.text = "비밀번호가 일치하지 않아요"
                        self?.topView.repaswwordLabel.warningLabel.isHidden = false
                    } else {
                        self?.topView.repasswordField.layer.borderWidth = 0
                        self?.topView.repaswwordLabel.warningLabel.isHidden = true
                    }
                    
                    if self?.topView.emailField.layer.borderWidth == 0 &&
                        self?.topView.passwordField.layer.borderWidth == 0 &&
                        self?.topView.repasswordField.layer.borderWidth == 0 {
                        UserDefaults.standard.set(text1, forKey: "email")
                        UserDefaults.standard.set(text2,forKey: "password")
                        let rp = AuthRepositoryImpl(loginAPI: LoginAPI())
                        let uc = LoginUseCase(authRepository: rp)
                        let vm = SignUpViewModel(usecase: uc)
                        let vc = NickNameViewController(viewModel: vm)
                        vc.modalPresentationStyle = .fullScreen
                        self?.present(vc,animated: false)
                    }
                }).disposed(by: self!.disposeBag)
            }).disposed(by: disposeBag)
        isAllEmptyBind()
    }
    
    
    func isAllEmptyBind() {
        let isEmailEmpty = topView.emailField.rx.text
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { text -> Bool in
                return !(text?.isEmpty ?? true)
            }.distinctUntilChanged()
        
        let isPassWordEmpty = topView.passwordField.rx.text
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { text -> Bool in
                return !(text?.isEmpty ?? true)
            }.distinctUntilChanged()
        
        let isRepasswordEmpty = topView.repasswordField.rx.text
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { text -> Bool in
                return !(text?.isEmpty ?? true)
            }.distinctUntilChanged()
        
        Observable.combineLatest(isEmailEmpty, isPassWordEmpty,isRepasswordEmpty)
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
        
        isEmailEmpty
            .withUnretained(self)
            .subscribe(onNext: { owner,info in
                if !info {
                    owner.topView.emailField.layer.borderWidth = 0
                    owner.topView.emailLabel.warningLabel.isHidden = true
                }
            }).disposed(by: disposeBag)
        
        isPassWordEmpty
            .withUnretained(self)
            .subscribe(onNext: { owner,info in
                if !info {
                    owner.topView.emailField.layer.borderWidth = 0
                    owner.topView.emailLabel.warningLabel.isHidden = true
                }
            }).disposed(by: disposeBag)
        
        isRepasswordEmpty
            .withUnretained(self)
            .subscribe(onNext: { owner,info in
                if !info {
                    owner.topView.emailField.layer.borderWidth = 0
                    owner.topView.emailLabel.warningLabel.isHidden = true
                }
            }).disposed(by: disposeBag)
    }
}
