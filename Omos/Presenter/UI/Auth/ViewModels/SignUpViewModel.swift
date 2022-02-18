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
    
    
    var signInfo = [String]()
    let usecase:LoginUseCase
    
    init(usecase:LoginUseCase) {
        self.usecase = usecase
        super.init()
    }
    
    //SignUP API Caller
    func signUp() {
    
        
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
    
    
}
