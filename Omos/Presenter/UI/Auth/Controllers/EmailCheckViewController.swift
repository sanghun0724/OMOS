//
//  EmailCheckController.swift
//  Omos
//
//  Created by sangheon on 2022/04/07.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class EmailCheckViewController: BaseViewController {
    private let viewModel: SignUpViewModel
    private let topView = SignUpView()
    let loadingView = LoadingView()

    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.backgroundColor = .mainGrey4
        button.setTitleColor(.mainGrey7, for: .normal)
        button.layer.cornerRadius = Constant.loginCorner
        button.layer.masksToBounds = true
        button.isEnabled = false
        return button
    }()

    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.isHidden = true
        loadingView.backgroundColor = .clear
        dismissKeyboardWhenTappedAround()
        bind()
        for i in 3...6 {
            topView.stack.arrangedSubviews[i].isHidden = true
        }
        self.navigationController?.navigationBar.isHidden = true
    }

    override func configureUI() {
        topView.coverView.titleLabel.text = "이메일 인증"
        view.addSubview(topView)
        view.addSubview(nextButton)
        view.addSubview(loadingView)
        guard let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height else { return }
        topView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().offset(height)
            make.height.equalToSuperview().multipliedBy(Constant.LoginTopViewHeight)
        }

        nextButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.06)
            make.bottom.equalToSuperview().offset(-40)
        }

        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func bind() {
        topView.coverView.backButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                self?.dismiss(animated: false, completion: nil)
            }).disposed(by: disposeBag)

        nextButton.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let isSuccess = self?.topView.emailCheckView.isSuccessView.isHidden else { return }
                if !isSuccess {
                    let rp = MyProfileRepositoryImpl(myProfileAPI: MyProfileAPI())
                    let uc = MyProfileUseCase(myProfileRepository: rp)
                    let vm = ProfileViewModel(usecase: uc)
                    let vc = PasswordChangeViewController(viewModel: vm)
                    self?.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let action = UIAlertAction(title: "확인", style: .default) { _ in
                    }
                    action.setValue(UIColor.mainOrange, forKey: "titleTextColor")
                    self?.presentAlert(title: "", message: "이메일 인증을 완료해주세요.", isCancelActionIncluded: false, preferredStyle: .alert, with: action)
                }
            }).disposed(by: disposeBag)

        topView.emailCheckView.labelView.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.emailVerify(email: self?.topView.emailField.text ?? "")
            }).disposed(by: disposeBag)

        viewModel.emailCheckCode
            .subscribe(onNext: { [weak self] _ in
                let alert = UIAlertController(title: "", message: "메일에서 받은 인증코드를 입력해주세요.", preferredStyle: .alert)
                alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.mainBackGround
                alert.view.tintColor = .mainGrey3
                alert.addTextField(configurationHandler: { textField in
                    textField.placeholder = "이메일 인증코드를 입력해주세요."
                })
                let ok = UIAlertAction(title: "완료", style: .default, handler: { _ -> Void in
                    self?.topView.emailCheckView.labelView.gestureRecognizers?.forEach( (self?.topView.emailCheckView.labelView.removeGestureRecognizer)!)
                    if alert.textFields?.first?.text ?? "" == self?.viewModel.currentEmailCheckCode.code {
                        print("same")
                        self?.viewModel.validEmailCheck.accept(true)
                        self?.topView.emailCheckView.labelView.isHidden = true
                        self?.topView.emailCheckView.isSuccessView.isHidden = false
                    } else {
                        print("diff")
                        self?.viewModel.validEmailCheck.accept(false)
                            let text = NSMutableAttributedString.init(string: "인증코드가 틀렸습니다. 다시 시도해주세요")
                                let range = NSRange(location: 0, length: text.length)
                                text.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red, range: range)
                                text.addAttribute(NSAttributedString.Key.font, value: UIFont.systemFont(ofSize: 16), range: range)
                        self?.topView.emailCheckView.labelView.attributedText = text
                    }
                })
                let cancel = UIAlertAction(title: "취소", style: .cancel) { _ -> Void in
                            print("Cancel button tapped")
                        }
                alert.addAction(ok)
                alert.addAction(cancel)
                self?.present(alert, animated: true, completion: nil)
            }).disposed(by: disposeBag)

        viewModel.loading
            .subscribe(onNext: { [weak self] loading in
                self?.loadingView.isHidden = !loading
            }).disposed(by: disposeBag)

        let isEmailEmpty = topView.emailField.rx.text
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .map { text -> Bool in
                !(text?.isEmpty ?? true)
            }.distinctUntilChanged()

        isEmailEmpty
            .withUnretained(self)
            .subscribe(onNext: { owner, info in
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
    }
}
