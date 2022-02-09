//
//  MusicRepository.swift
//  Omos
//
//  Created by sangheon on 2022/02/09.
//

import RxSwift

protocol MusicRepository {
    func fetchMusicList(keyword:String) -> Single<StockResult>
}
