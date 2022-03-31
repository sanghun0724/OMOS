//
//  LoginViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/10.
//
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import Foundation
import RxSwift
import RxRelay
import UIKit
import RxAlamofire

class LoginViewModel: BaseViewModel {
    
    let validSignIn = PublishRelay<Bool>()
    let ischeckedSubject = PublishRelay<Bool>()
    let hasKakaoEmail = PublishRelay<Bool>()
    let usecase:LoginUseCase
    
    init(usecase:LoginUseCase) {
        self.usecase = usecase
        super.init()
    }
    
    
    

    func loginLocal(email:String,password:String) {
        usecase.signIn(email: email, password: password).subscribe({ [weak self] result in
            switch result {
            case .success(let data):
                UserDefaults.standard.set(data.accessToken, forKey: "access")
                UserDefaults.standard.set(data.refreshToken, forKey: "refresh")
                UserDefaults.standard.set(data.userId, forKey: "user")
                Account.currentUser = UserDefaults.standard.integer(forKey: "user")
                self?.validSignIn.accept(true)
            case .failure(let error):
                print(error)
                self?.validSignIn.accept(false)
            }
        }).disposed(by: disposeBag)
        
    }

    
    
    //MARK: KAKAO LOGIN
     func loginKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken,error) in
                if let error = error {
                    print(error.localizedDescription)
                    print("카카오 에러")
                    return
                } else {
                    self.getUserInfo()
                }
            }
        }
    }
    
 func getUserInfo() {
        //사용자 정보 가져오기
        UserApi.shared.me { user, error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                let id = user?.id ?? 0
                print(id)
                UserDefaults.standard.set("\(id)@kakao.com", forKey: "kakaoEmail")
                LoginAPI.SNSLogin(request: .init(email: "\(id)@kakao.com", type: .KAKAO)) { [weak self] result in
                    switch result {
                    case .success(let token):
                        UserDefaults.standard.set(token.accessToken, forKey: "access")
                        UserDefaults.standard.set(token.refreshToken, forKey: "refresh")
                        UserDefaults.standard.set(token.userId, forKey: "user")
                        self?.hasKakaoEmail.accept(true)
                    case .failure:
                        self?.hasKakaoEmail.accept(false)
                    }
                }
            }
        }
    }
    
    //서버로 토큰관리할거면 이거로 자동로그인 해야함 리프레쉬토큰
    //근데 우리는 사용하다 실패시 dorefresh 할거니.. -> refresh함수를 인터셉터에 넣어주면 댐 그냥
    static func hasKaKaoToken(completion:@escaping (Bool) -> Void) {
        
        if AuthApi.hasToken() {
            UserApi.shared.accessTokenInfo { token, error in
                if let error = error {
                    //엑세트 토큰이나 리프레쉬토큰 만료
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        //로그인 다시 해야함
                        completion(false)
                    } else {
                        //기타 에러
                        completion(false)
                    }
                } else {
                    //토큰 유효성 체크 성공(필요시 토큰 갱신됨)
                    //사용자 정보 가져오고 화면전환이나 기타
                    completion(true)
                    //tabbar
                }
            }
        } else {
            //토큰 없으니 로그인 하셍
            completion(false)
        }
    }
}
