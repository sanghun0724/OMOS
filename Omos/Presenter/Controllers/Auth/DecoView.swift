//
//  DecoView.swift
//  Omos
//
//  Created by sangheon on 2022/02/10.
//

import UIKit


class DecoView:BaseView {
    
    
}

class EmailLabelView:BaseView {
    let emailLabel:UILabel = {
       let label = UILabel()
        label.text = "이메일"
        //label.font = .systemFont(ofSize: <#T##CGFloat#>, weight: <#T##UIFont.Weight#>)
        label.tintColor = .white
        return label
    }()
    
    
    let warningLabel:UILabel = {
       let label = UILabel()
        label.text = "wdqwdwqdwqd"
        label.textAlignment = .right
        return label
    }()
    
    override func configureUI() {
        self.addSubview(emailLabel)
        self.addSubview(warningLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        
        warningLabel.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(200)
        }
    }
}


class PasswordLabelView:BaseView {
    let passwordLabel:UILabel = {
       let label = UILabel()
        label.text = "비밀번호"
        //label.font = .systemFont(ofSize: <#T##CGFloat#>, weight: <#T##UIFont.Weight#>)
        label.tintColor = .white
        return label
    }()
    
    
    let warningLabel:UILabel = {
       let label = UILabel()
        label.text = "wdqwdq"
        label.textAlignment = .right
        return label
    }()
    
    override func configureUI() {
        self.addSubview(passwordLabel)
        self.addSubview(warningLabel)
        
        passwordLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(100)
        }
        
        warningLabel.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(200)
        }
    }
}


class labels:BaseView {
    let findIDButton:UIButton = {
       let button = UIButton()
        button.setTitle("아이디찾기", for: .normal)
        return button
    }()
    
    let dummyView:UIView = {
       let view = UIView()
        view.backgroundColor = .mainGrey
        return view
    }()
    
    let findPWButton:UIButton = {
        let button = UIButton()
         button.setTitle("비밀번호 찾기", for: .normal)
         return button
    }()
    
    let signUpButton:UIButton = {
        let button = UIButton()
        button.setTitle("회원가입", for: .normal)
        return button
    }()
    
    override func configureUI() {
//        self.addSubview(findIDButton)
//        self.addSubview(findPWButton)
//        self.addSubview(dummyView)
        self.addSubview(signUpButton)
        
//        findIDButton.snp.makeConstraints { make in
//            make.left.top.bottom.equalToSuperview()
//            make.height.equalTo(64)
//        }
//
//        dummyView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview()
//            make.left.equalTo(findIDButton.snp.right).inset(1)
//            make.width.equalTo(1)
//        }
//
//        findPWButton.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview()
//            make.left.equalTo(dummyView.snp.right).inset(1)
//            make.width.equalTo(64)
//        }
        
        signUpButton.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
            make.width.equalTo(64)
        }
        
    }
    
}
