//
//  LoginViewController.swift
//  Omos
//
//  Created by sangheon on 2022/02/05.
//

import UIKit
import AuthenticationServices
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon

class LoginViewController:BaseViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setAppleButton()
        
        view.addSubview(kakaoButton)
        kakaoButton.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
    }
    
    //MARK: KAKAO LOGIN
    private let kakaoButton:UIButton = {
        let bt = UIButton()
        bt.addTarget(self, action: #selector(loginKakao), for: .touchUpInside)
        bt.backgroundColor = .yellow
        return bt
    }()
    

    @objc func loginKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken,error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    print("kakao login success")
                    UserDefaults.standard.set(oauthToken, forKey: "kakao")
                    
                    self.getUserInfo()
                }
                
            }
        }
    }
    
    
    //MARK: APPLE LOGIN
    func setAppleButton() {
        let button = ASAuthorizationAppleIDButton(authorizationButtonType: .signIn, authorizationButtonStyle: .black)
        button.addTarget(self, action: #selector(loginHandler), for: .touchUpInside)
        self.view.addSubview(button)
        button.center = self.view.center
    }
    
    @objc func loginHandler() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName,.email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
    }
    
}

//Apple
extension LoginViewController:ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let credential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let user = credential.user
            print("user:\(user)")
            if let email = credential.email {
                print("email:\(email)")
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Apple Login Error:\(error.localizedDescription)")
    }
}


//Kakao
extension LoginViewController {
    private func getUserInfo() {
        //사용자 정보 가져오기
        UserApi.shared.me { user, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
                let nickName = user?.kakaoAccount?.profile?.nickname
                let email = user?.kakaoAccount?.email
                
                print("user info \(nickName),\(email)")
            }
        }
    }
    
    //서버로 토큰관리할거면 이거로 자동로그인 해야함 리프레쉬토큰
    private func hasKaKaoToken() {
        
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { token, error in
                if let error = error {
                    //엑세트 토큰이나 리프레쉬토큰 만료
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        //로그인 다시 해야함
                    } else {
                        //기타 에러
                    }
                } else {
                    //토큰 유효성 체크 성공(필요시 토큰 갱신됨)
                    //사용자 정보 가져오고 화면전환이나 기타
                    self.getUserInfo()
                    //tabbar
                }
            }
        } else {
            //토큰 없으니 로그인 하셍
        }
    }
}
