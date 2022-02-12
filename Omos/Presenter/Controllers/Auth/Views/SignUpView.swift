//
//  SignUpView.swift
//  Omos
//
//  Created by sangheon on 2022/02/12.
//

import UIKit

class SignUpView:BaseView {
    
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
    
    let repasswordField:UITextField = {
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
    
    let emailLabel:EmailLabelView = {
        let view = EmailLabelView()
        return view
    }()
    
    let passwordLabel:PasswordLabelView = {
        let view = PasswordLabelView()
        return view
    }()
    
    let repaswwordLabel:PasswordLabelView = {
        let view = PasswordLabelView()
        return view
    }()
    
    lazy var views = [emailLabel,emailField,passwordLabel,passwordField,repaswwordLabel,repasswordField]
    
    private lazy var stack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: views)
        stack.axis = .vertical
        return stack
    }()
    
    
    override func configureUI() {
        self.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview()
        }
        
        for view in views {
            view.snp.makeConstraints { make in
                make.height.equalTo(self.snp.height).multipliedBy(0.089)
            }
        }
    }
    
}
