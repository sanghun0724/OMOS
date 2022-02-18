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

class LoginVeiwModel: BaseViewModel {
    
    let idPublishSubject = PublishSubject<String>()
    let pwPublishSubject = PublishSubject<String>()
    let ischeckedSubject = BehaviorRelay<Bool>(value:false)
//    let usecase:MusicUseCase
//    
//    init(usecase:MusicUseCase) {
//        self.usecase = usecase
//        super.init()
//    }
    
    
    

    func loginLocal() {
        //set LoginActionLogic
        
    }
    
    
    
    //MARK: Check Button Logic
    func isChecked(_ button:UIButton) {
        if button.backgroundColor == .white {
            button.backgroundColor = .mainOrange
        } else  {
            button.backgroundColor = .white
        }
    }
    
    func hasSameName() -> Bool {
        return false 
    }
    
    
    //MARK: KAKAO LOGIN
     func loginKakao() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk { (oauthToken,error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                } else {
                    print("kakao login success")
                    UserDefaults.standard.set(oauthToken?.accessToken, forKey: "kakaoAccess")
                    UserDefaults.standard.set(oauthToken?.refreshToken, forKey: "kakaoRefresh")
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
                let id = user?.id
                let nickName = user?.kakaoAccount?.profile?.nickname
                let email = user?.kakaoAccount?.email
                
                
                print("user info \(nickName),\(email)")
            }
        }
    }
    
    //서버로 토큰관리할거면 이거로 자동로그인 해야함 리프레쉬토큰
    func hasKaKaoToken() {
        
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
