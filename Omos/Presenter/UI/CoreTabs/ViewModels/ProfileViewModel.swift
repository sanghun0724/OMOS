//
//  ProfileViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/18.
//

import Foundation
import RxSwift

class ProfileViewModel:BaseViewModel {
    
    let myDjList = PublishSubject<[MyDjListResponse]>()
    var currentMyDjList:[MyDjListResponse] = []
    let loading = BehaviorSubject<Bool>(value:false)
    let isEmpty = BehaviorSubject<Bool>(value:false)
    let errorMessage = BehaviorSubject<String?>(value: nil)
    
    
    
    
}
