//
//  NickNameView.swift
//  Omos
//
//  Created by sangheon on 2022/02/13.
//

import UIKit

class NickNameView:BaseView {
    
    let coverView = CoverView()
    let privateLabel1 = PrivateLabelView()
    let privateLabel2 = PrivateLabelView()
    
    let nickNameLabel:EmailLabelView = {
        let view = EmailLabelView()
        view.emailLabel.text = "닉네임"
        view.warningLabel.text = "닉네임을 입력해주세요"
        return view
    }()
    
    let nickNameField:UITextField = {
        let field = UITextField()
        field.placeholder = "닉네임을 입력해주세요"
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
    
    let dummyView:UIView = {
        let view = UIView()
        view.backgroundColor = .mainGrey7
        return view
    }()
    
    
    override func configureUI() {
        self.addSubview(coverView)
        self.addSubview(nickNameLabel)
        self.addSubview(nickNameField)
        self.addSubview(privateLabel1)
        self.addSubview(privateLabel2)
        self.addSubview(dummyView)
                
        coverView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.42)
        }
        
        nickNameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(coverView.snp.bottom)
            make.height.equalTo(self.snp.height).multipliedBy(0.089)
        }
        
        nickNameField.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(nickNameLabel.snp.bottom)
            make.height.equalTo(self.snp.height).multipliedBy(0.089)
        }
        
        dummyView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(nickNameField.snp.bottom).offset(26)
        }
        
        privateLabel1.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(dummyView.snp.bottom).offset(26)
            make.height.equalTo(self.snp.height).multipliedBy(0.089)
        }
        
        privateLabel2.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalTo(privateLabel1.snp.bottom)
            make.height.equalTo(self.snp.height).multipliedBy(0.089)
        }
        privateLabel2.label.text = "(필수) 개인정보 보호정책에 동의합니다."
        
    }

}
