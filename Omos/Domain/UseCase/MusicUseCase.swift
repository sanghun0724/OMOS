//
//  MusicUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import Foundation
import RxSwift

class MusicUseCase {
    
    private let musicRepository:MusicRepository
    
    func fetchMusicList(keyword:String) -> Single<StockResult> {
        musicRepository.fetchMusicList(keyword: keyword)
    }
    
    init(musicRepository:MusicRepository) {
        self.musicRepository = musicRepository
    }
    
}
