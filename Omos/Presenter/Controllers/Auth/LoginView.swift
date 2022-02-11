//
//  LoginView.swift
//  Omos
//
//  Created by sangheon on 2022/02/10.
//

import UIKit

class LoginView:BaseView {
    
    let coverView = UIView()
    
    let imageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "onboarding_logo"))
        return imageView
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "로그인"
        label.font = .systemFont(ofSize: 22)
        label.textColor = .mainOrange
        return label
    }()
    
    let emailField:UITextField = {
        let field = UITextField()
        field.placeholder = "이메일(아이디)를 입력해주세요"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.layer.cornerRadius = Constant.loginCorner
        field.layer.masksToBounds = true
        field.leftViewMode = .always
        field.leftView = UIView(frame:CGRect(x: 0, y: 0, width: 10, height: 50))
        field.textColor = .white
        field.backgroundColor = .black
        return field
    }()
    
    let passwordField:UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 입력해주세요"
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
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
    
    private let passwordDecoView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: "visible2" ))
        return imageView
    }()
    
    private let emailLabel:EmailLabelView = {
        let labelView = EmailLabelView()
        return labelView
    }()
    
    private let passwordLabel:PasswordLabelView = {
        let labelView = PasswordLabelView()
        return labelView
    }()
    
    private let labelsView:labels = {
        let view = labels()
        return view
    }()
    
    lazy var views = [emailLabel,emailField,passwordLabel,passwordField,labelsView]
    
    private lazy var stack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .vertical
        return stack
    }()
    
    
    override func configureUI() {
        self.backgroundColor = .mainBackGround
        passwordField.addSubview(passwordDecoView)
        coverView.addSubview(imageView)
        coverView.addSubview(titleLabel)
        self.addSubview(coverView)
        self.addSubview(stack)
        coverView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.396)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(74)
            make.width.equalTo(77.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(60)
        }
        
        stack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(coverView.snp.bottom)
        }
        
        for view in views {
            view.snp.makeConstraints { make in
                make.height.equalTo(self.snp.height).multipliedBy(0.089)
            }
        }
        
        passwordDecoView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
            make.width.greaterThanOrEqualTo(24)
        }
        
    }
}

