//
//  NickNameView.swift
//  Omos
//
//  Created by sangheon on 2022/02/13.
//

import UIKit

class NickNameView:BaseView {
    
    let coverView = CoverView()
    
    let nickNameLabel:EmailLabelView = {
        let view = EmailLabelView()
        view.emailLabel.text = "닉네임"
        return view
    }()
    
    let nickNameField:UITextField = {
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
    
    
    override func configureUI() {
        self.addSubview(coverView)
        self.addSubview(nickNameLabel)
        self.addSubview(nickNameField)
                
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
        
    }
    
    
}
