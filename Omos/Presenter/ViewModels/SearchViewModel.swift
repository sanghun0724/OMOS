//
//  SearchViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import RxSwift

class SearchViewModel :BaseViewModel{
    
    let loading = BehaviorSubject<Bool>(value:false)
    let usecase:MusicUseCase
    
    
    func searchQeuryChanged(query:String) {
        loading.onNext(true)
        usecase.fetchMusicList(keyword: query)
            .subscribe({ _ in
                    print("this is viewModel")
            }).disposed(by: disposeBag)
        
    }
    
    
    
    init(usecase:MusicUseCase) {
        self.usecase = usecase
        super.init()
        self.reduce()
    }
    
    
    func reduce() {
        
    }
}
