//
//  ButtonView.swift
//  Omos
//
//  Created by sangheon on 2022/02/10.
//

import UIKit
import AuthenticationServices

class ButtonView:BaseView {
    
    let loginButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = Constant.loginCorner
        button.backgroundColor = .mainGrey4
        button.setTitle("로그인", for: .normal)
        button.setTitleColor(.mainGrey7, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.masksToBounds = true
        return button
    }()
    
    let decoView:DecoView = {
        let view = DecoView()
        return view
    }()
    
    private let kakaoImageView = UIImageView(image: UIImage(named: "Kakao"))
    private let kakaoLabel:UILabel = {
        let label = UILabel()
        label.text = "카카오로 로그인"
        return label
    }()
    
    let kakaoButton:UIButton = {
        let bt = UIButton()
        bt.layer.cornerRadius = Constant.loginCorner
        bt.setTitle("    Kakao로 로그인", for: .normal)
        bt.titleLabel?.textAlignment = .right
        bt.setTitleColor(.buttonLabel, for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 20,weight: .semibold)
        bt.backgroundColor = .kakaoYellow
        
        return bt
    }()
    
    let appleButton:ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .white)
        button.cornerRadius = Constant.loginCorner
        return button
    }()
    
    
    override func configureUI() {
        kakaoButton.addSubview(kakaoImageView)
        kakaoButton.addSubview(kakaoLabel)
        self.addSubview(loginButton)
        self.addSubview(decoView)
        self.addSubview(appleButton)
        self.addSubview(kakaoButton)
        
        loginButton.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.20)
        }
        
        decoView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.14)
        }
        
        kakaoButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(decoView.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.20)
        }
        
        appleButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(kakaoButton.snp.bottom).offset(14)
            make.height.equalToSuperview().multipliedBy(0.20)
        }
        
        kakaoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().multipliedBy(0.62)
            make.height.width.equalTo(16)
        }
        
    }
    
}


