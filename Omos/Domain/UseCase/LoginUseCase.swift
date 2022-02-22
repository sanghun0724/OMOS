//
//  LoginUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Foundation
import RxSwift

class LoginUseCase {
    
    private let musicRepository:MusicRepository
    
    func signIn(email:String,password:String) -> Single<LoginResponse> {
        return musicRepository.signIn(email, password)
    }
    
    func signUp(email:String,password:String,nickname:String) -> Single<SignUpRespone> {
       return musicRepository.localSignUp(email, password, nickname)
    }
    
    func checkEmail(email:String) -> Single<CheckEmailRespone> {
        return musicRepository.checkEmail(email: email)
    }
    
    func snsLogin(email:String,type:SNSType) -> Single<SNSLoginResponse> {
        return musicRepository.snsLogin(email: email, type: type)
    }
    
    func snsSignUp(email:String,nickName:String,type:SNSType) -> Single<SNSSignUpResponse> {
        return musicRepository.snsSignUp(email: email, nickName: nickName, type: type)
    }
    
    
    init(musicRepository:MusicRepository) {
        self.musicRepository = musicRepository
    }
    
}
