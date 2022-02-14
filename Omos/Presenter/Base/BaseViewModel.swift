//
//  BaseViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/05.
//

import Foundation
import RxSwift

class BaseViewModel {
    var disposeBag:DisposeBag = .init()
    
    init() {
        disposeBag = .init()
    }
}
