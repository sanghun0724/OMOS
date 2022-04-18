//
//  TodayUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/03/15.
//

import Foundation
import RxSwift

class TodayUseCase {
    private let todayRepository: TodayRepository

    init(todayRepository: TodayRepository) {
        self.todayRepository = todayRepository
    }

    func popuralRecord() -> Single<[PopuralResponse]> {
        todayRepository.popuralRecord()
    }

    func lovedRecord(userId: Int) -> Single<LovedResponse> {
        todayRepository.lovedRecord(userId: userId)
    }

    func recommendDJRecord() -> Single<[RecommendDjResponse]> {
        todayRepository.recommendDJRecord()
    }

    func todayRecord() -> Single<TodayTrackResponse> {
        todayRepository.todayRecord()
    }
}
