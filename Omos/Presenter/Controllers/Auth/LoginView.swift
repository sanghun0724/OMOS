//
//  LoginView.swift
//  Omos
//
//  Created by sangheon on 2022/02/10.
//

import Foundation
import UIKit
import SnapKit
import SwiftUI

class LoginView:BaseView {
    
    let coverView = UIView()
    
    let imageView:UIImageView = {
        let imageView = UIImageView(image:UIImage(named: ""))
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    let loginButton:UIButton  = {
       let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    
    let emailField:UITextField = {
        let field = UITextField()
        field.placeholder = "이메일(아이디)를 입력해주세요"
        field.textColor = .white
        field.backgroundColor = .black
        return field
    }()
    
    let passwordField:UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 입력해주세요"
        field.textColor = .white
        field.backgroundColor = .black
        return field
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
        backgroundColor = .purple
        coverView.addSubview(imageView)
        coverView.addSubview(loginButton)
        self.addSubview(coverView)
        self.addSubview(stack)
        coverView.backgroundColor = .orange
        coverView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.396)
        }
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(60)
            make.width.equalTo(100)
        }
        
        loginButton.snp.makeConstraints { make in
            make.left.bottom.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(100)
        }
        
        stack.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(10)
            make.top.equalTo(coverView.snp.bottom)
        }
        
        for view in views {
            view.snp.makeConstraints { make in
                make.height.equalTo(self.snp.height).multipliedBy(0.089)
            }
        }
        
    }
}

