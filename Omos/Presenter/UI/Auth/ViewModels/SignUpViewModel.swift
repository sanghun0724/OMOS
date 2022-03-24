//
//  SignUpViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/18.
//

import UIKit
import RxSwift
import RxRelay

class SignUpViewModel:BaseViewModel {
    
    
    let validSignUp = PublishRelay<Bool>()
    let validEmail = PublishRelay<Bool>()
    let usecase:LoginUseCase
    
    init(usecase:LoginUseCase) {
        self.usecase = usecase
        super.init()
    }
    
    //SignUP API Caller
    func signUp() {
        guard let email = UserDefaults.standard.string(forKey: "email"),
                let password = UserDefaults.standard.string(forKey: "password"),
                let nickname = UserDefaults.standard.string(forKey: "nickname") else {
                    return
                }
        print("sign \(email),\(password),\(nickname)")
        
        usecase.signUp(email: email, password: password, nickname: nickname)
            .subscribe( { [weak self] event in
                switch event {
                case .success:
                    self?.validSignUp.accept(true)
                case .failure:
                    self?.validSignUp.accept(false)
                }
            }).disposed(by: disposeBag)
    }
    
    func kakaoSignUp() {
        guard let email =  UserDefaults.standard.string(forKey: "kakaoEmail"),
              let nickname = UserDefaults.standard.string(forKey: "nickname") else {
                  return
              }
        print(email)
        print(nickname)
        usecase.snsSignUp(email: email, nickName: nickname, type: .KAKAO).subscribe({ [weak self] event in
            switch event {
            case .success:
                self?.validSignUp.accept(true)
            case .failure:
                self?.validSignUp.accept(false)
            }
        }).disposed(by: disposeBag)
    }
    
    func appleSignUp() {
        guard let email =  UserDefaults.standard.string(forKey: "appleEmail"),
              let nickname = UserDefaults.standard.string(forKey: "nickname") else {
                  return
              }
        print("okk\(email)")
        usecase.snsSignUp(email: email, nickName: nickname, type: .APPLE).subscribe({ [weak self] event in
            switch event {
            case .success:
                self?.validSignUp.accept(true)
            case .failure:
                self?.validSignUp.accept(false)
            }
        }).disposed(by: disposeBag)
    }
    
    //MARK: Check Button Logic
    func isChecked(_ button:UIButton) {
        if button.backgroundColor == .white {
            button.backgroundColor = .mainOrange
        } else  {
            button.backgroundColor = .white
        }
    }
    
    func hasSameName(email:String) {
        usecase.checkEmail(email: email).subscribe({ [weak self] event in
            switch event {
            case .success(let data):
                print(data)
                self?.validEmail.accept(data.state)
            case .failure(let error):
                self?.validEmail.accept(false)
                print(error.localizedDescription)
            }
        }).disposed(by: disposeBag)
    }
    
    
}
