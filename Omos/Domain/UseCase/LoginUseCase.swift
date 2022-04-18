//
//  LoginUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/02/17.
//

import Foundation
import RxSwift

class LoginUseCase {
    private let authRepository: AuthRepository

    func signIn(email: String, password: String) -> Single<LoginResponse> {
        authRepository.signIn(email, password)
    }

    func signUp(email: String, password: String, nickname: String) -> Single<SignUpRespone> {
        authRepository.localSignUp(email, password, nickname)
    }

    func checkEmail(email: String) -> Single<CheckEmailRespone> {
        authRepository.checkEmail(email: email)
    }

    func snsLogin(email: String, type: SNSType) -> Single<SNSLoginResponse> {
        authRepository.snsLogin(email: email, type: type)
    }

    func snsSignUp(email: String, nickName: String, type: SNSType) -> Single<SNSSignUpResponse> {
        authRepository.snsSignUp(email: email, nickName: nickName, type: type)
    }

    func emailVerify(email: String) -> Single<EmailCheckResponse> {
        authRepository.emailVerify(email: email)
    }

    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
}
