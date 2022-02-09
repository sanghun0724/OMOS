//
//  MusicRepositoryImpl.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import RxSwift

class MusicRepositoryImpl:MusicRepository {
    
    let apiKey:String = "H4ZRG44U4X1T6VSV"
    
    func fetchMusicList(keyword: String) -> Single<StockResult> {
        print(keyword)
        return Single<StockResult>.create { single in
            return Disposables.create()
        }
    }
    
    
    func parseKeyword() {
        
    }
    
}
