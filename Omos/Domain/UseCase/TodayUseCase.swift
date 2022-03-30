//
//  TodayUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/03/15.
//

import Foundation
import RxSwift

class TodayUseCase {
    private let todayRepository:TodayRepository
    
    init(todayRepository:TodayRepository) {
        self.todayRepository = todayRepository
    }
    
    func popuralRecord() -> Single<[PopuralResponse]> {
        return todayRepository.popuralRecord()
    }
    
    func lovedRecord(userId:Int) -> Single<LovedResponse> {
        return todayRepository.lovedRecord(userId: userId)
    }
    
    func recommendDJRecord() -> Single<[recommendDjResponse]> {
        return todayRepository.recommendDJRecord()
    }
    
    func todayRecord() -> Single<TodayTrackResponse> {
        return todayRepository.todayRecord()
    }
    
}
