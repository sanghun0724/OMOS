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
    
    
    let validSignUp = BehaviorRelay<Bool>(value: false)
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
    
    //MARK: Check Button Logic
    func isChecked(_ button:UIButton) {
        if button.backgroundColor == .white {
            button.backgroundColor = .mainOrange
        } else  {
            button.backgroundColor = .white
        }
    }
    
    func hasSameName(email:String,completion:@escaping(Bool) -> Void) {
        LoginAPI.checkEmail(email:email) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
