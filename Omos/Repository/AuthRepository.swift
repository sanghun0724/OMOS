//
//  MusicRepository.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import RxSwift

protocol AuthRepository {
    init(loginAPI: LoginAPI)
    func signIn(_ email: String, _ password: String) -> Single<LoginResponse>
    func localSignUp(_ email: String, _ password: String, _ nickname: String) -> Single<SignUpRespone>
    func checkEmail(email: String) -> Single<CheckEmailRespone>
    func snsLogin(email: String, type: SNSType) -> Single<SNSLoginResponse>
    func snsSignUp(email: String, nickName: String, type: SNSType) -> Single<SNSSignUpResponse>
    func emailVerify(email: String) -> Single<EmailCheckResponse>
}
