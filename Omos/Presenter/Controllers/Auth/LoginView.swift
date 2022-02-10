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
        field.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        field.textColor = .white
        field.backgroundColor = .black
        return field
    }()
    
    let passwordField:UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 입력해주세요"
        field.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        field.textColor = .white
        field.backgroundColor = .black
        return field
    }()
    
    private let emailLabel:UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.tintColor = .white
        return label
    }()
    
    private let passwordLabel:UILabel = {
        let label = UILabel()
        label.text = "비밀번호"
        label.tintColor = .white
        return label
    }()
    
    private let labelsView:labels = {
       let view = labels()
        return view
    }()
    
    
    private lazy var stack:UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailLabel,emailField,passwordLabel,passwordField])
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
            make.height.equalTo(260)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
    }
}



class labels:BaseView {
    
}
