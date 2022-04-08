//
//  PasswordChangViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import UIKit

class PasswordChangeViewController:BaseViewController {
    
    let selfView = PasswordChangeView()
    let viewModel:ProfileViewModel
    var passwordFlag = false
    var repasswordFlag = false
    
    init(viewModel:ProfileViewModel) {
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
                guard let text =  self?.selfView.passwordField.text else  {
                    //alert nickname입력해주세요
                    print("alert")
                    return
                }
                
                guard let retext =  self?.selfView.repasswordField.text else  {
                    //alert nickname입력해주세요
                    print("alert")
                    return
                }
                
                if text.count >= 8 && text.count <= 16 && !(text.hasCharacters()) && retext == text{
                    self?.viewModel.updatePassword(request: .init(password: text, userId: Account.currentUser))
                    self?.navigationController?.popViewController(animated: true)
                } else {
                    self?.selfView.passwordField.layer.borderWidth = 1
                    self?.selfView.passwordField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                    self?.selfView.warningLabel.text = "비밀번호 양식을 다시 확인해주세요."
                    self?.selfView.warningLabel.isHidden = false
                }
                
                if retext != text {
                    self?.selfView.repasswordField.layer.borderWidth = 1
                    self?.selfView.repasswordField.layer.borderColor = .some(UIColor.mainOrange.cgColor)
                    self?.selfView.rewarningLabel.text = "비밀번호가 일치하지 않습니다."
                    self?.selfView.rewarningLabel.isHidden = false
                } else {
                    self?.selfView.repasswordField.layer.borderWidth = 0
                    self?.selfView.rewarningLabel.isHidden = true
                }
                
                       }).disposed(by: disposeBag)
        
        selfView.passwordDecoView.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                if !(self?.passwordFlag)! {
                    self?.selfView.passwordField.isSecureTextEntry = false
                    self?.selfView.passwordDecoView.setImage(UIImage(named: "visible1" ), for: .normal)
                    self?.passwordFlag = true
                } else {
                    self?.selfView.passwordField.isSecureTextEntry = true
                    self?.selfView.passwordDecoView.setImage(UIImage(named: "visible2" ), for: .normal)
                    self?.passwordFlag = false
                }
            }).disposed(by: disposeBag)
        
        selfView.repasswordDecoView.rx.tap
            .asDriver()
            .drive(onNext: { [weak self] in
                if !(self?.repasswordFlag)! {
                    self?.selfView.repasswordField.isSecureTextEntry = false
                    self?.selfView.repasswordDecoView.setImage(UIImage(named: "visible1" ), for: .normal)
                    self?.repasswordFlag = true
                } else {
                    self?.selfView.repasswordField.isSecureTextEntry = true
                    self?.selfView.repasswordDecoView.setImage(UIImage(named: "visible2" ), for: .normal)
                    self?.repasswordFlag = false
                }
            }).disposed(by: disposeBag)

    }
    
    
}


class PasswordChangeView:BaseView {
    
    let mentionLabel:UILabel = {
        let label = UILabel()
        label.text = "새로운 비밀번호를 입력해주세요."
        label.textColor = .white
        return label
    }()
    
    let passwordField:UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 입력해주세요"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.textContentType = .password
        field.isSecureTextEntry = true
        field.layer.cornerRadius = Constant.loginCorner
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 50))
        field.textColor = .white
        field.backgroundColor = .black
        field.rightViewMode = .always
        return field
    }()
    
    let passwordDecoView:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "visible2" ), for: .normal)
        return button
    }()
    
    let warningLabel:UILabel = {
       let label = UILabel()
        label.text = "비밀번호 양식을 확인해주세요"
        label.font = .systemFont(ofSize:12)
        label.textColor = .mainOrange
        label.textAlignment = .right
        return label
    }()
    
    let rementionLabel:UILabel = {
        let label = UILabel()
        label.text = "비밀번호 재확인"
        label.textColor = .white
        return label
    }()
    
    let repasswordField:UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 다시 입력해주세요."
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.textContentType = .password
        field.isSecureTextEntry = true
        field.layer.cornerRadius = Constant.loginCorner
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 50))
        field.textColor = .white
        field.backgroundColor = .black
        field.rightViewMode = .always
        return field
    }()
    
    let repasswordDecoView:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "visible2" ), for: .normal)
        return button
    }()
    
    let rewarningLabel:UILabel = {
       let label = UILabel()
        label.text = "비밀번호가 일치하지 않아요."
        label.font = .systemFont(ofSize:12)
        label.textColor = .mainOrange
        label.textAlignment = .right
        return label
    }()
    
    let buttonView:UIButton = {
       let button = UIButton()
        button.backgroundColor = .mainGrey4
        button.setTitle("완료", for: .normal)
        button.setTitleColor(.mainGrey7, for: .normal)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
       
    }
    
    
    override func configureUI() {
        super.configureUI()
        self.addSubview(mentionLabel)
        self.addSubview(passwordField)
        self.addSubview(warningLabel)
        self.addSubview(rementionLabel)
        self.addSubview(repasswordField)
        self.addSubview(rewarningLabel)
        self.addSubview(buttonView)
        passwordField.addSubview(passwordDecoView)
        repasswordField.addSubview(repasswordDecoView)
        
        mentionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(34)
            mentionLabel.sizeToFit()
        }
        
        warningLabel.snp.makeConstraints { make in
            make.leading.equalTo(mentionLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(passwordField.snp.bottom).offset(4)
            warningLabel.sizeToFit()
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(mentionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        
        buttonView.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(passwordField)
            make.bottom.equalToSuperview().offset(-34)
        }
        
        passwordDecoView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(24)
        }
        
        rementionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(warningLabel.snp.bottom).offset(8)
            mentionLabel.sizeToFit()
        }
        
        rewarningLabel.snp.makeConstraints { make in
            make.leading.equalTo(rementionLabel)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(repasswordField.snp.bottom).offset(4)
            warningLabel.sizeToFit()
        }
        
        repasswordField.snp.makeConstraints { make in
            make.top.equalTo(rementionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.06)
        }
        
        
        repasswordDecoView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(24)
        }
        
        rewarningLabel.isHidden = true
        warningLabel.isHidden = true
    }
    
    
    
    
    
}
