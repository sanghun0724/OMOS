//
//  PasswordChangViewController.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import UIKit

class PasswordChangeViewController:BaseViewController {
    
    let selfView = PasswordChangeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.addSubview(buttonView)
        
      
        
        mentionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(34)
            mentionLabel.sizeToFit()
        }
        
        passwordField.snp.makeConstraints { make in
            make.top.equalTo(mentionLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(16)
            make.height.equalToSuperview().multipliedBy(0.07)
        }
        
        buttonView.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(passwordField)
            make.bottom.equalToSuperview().offset(-34)
        }
        
    }
    
    
    
    
    
}
