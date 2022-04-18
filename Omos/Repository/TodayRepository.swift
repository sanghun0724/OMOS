//
//  TodayRepository.swift
//  Omos
//
//  Created by sangheon on 2022/03/15.
//

import Foundation
import RxSwift

protocol TodayRepository {
    var todayAPI: TodayAPI { get }
    init(todayAPI: TodayAPI)
    func popuralRecord() -> Single<[PopuralResponse]>
    func lovedRecord(userId: Int) -> Single<LovedResponse>
    func recommendDJRecord() -> Single<[RecommendDjResponse]>
    func todayRecord() -> Single<TodayTrackResponse>
}
