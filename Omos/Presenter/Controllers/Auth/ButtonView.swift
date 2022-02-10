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
        return button
    }()
    
    let decoView:DecoView = {
        let view = DecoView()
        view.backgroundColor = .purple
        return view
    }()
    
    let kakaoButton:UIButton = {
       let bt = UIButton()
        bt.layer.cornerRadius = 8
       bt.backgroundColor = .yellow
       return bt
   }()
    
     let appleButton:ASAuthorizationAppleIDButton = {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
        button.cornerRadius = 8
        return button
    }()
    
    
    override func configureUI() {
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

        
    }
    
}


