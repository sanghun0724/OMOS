//
//  MusicUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import RxSwift

class SearchUseCase {
    
    private let searchRepository:SearchRepository
    
    func fetchMusicList(keyword:String) -> Single<StockResult> {
        searchRepository.fetchMusicList(keyword: keyword)
    }
    
    init(searchRepository:SearchRepository) {
        self.searchRepository = searchRepository
    }
    
}
