//
//  RecordsRepository.swift
//  Omos
//
//  Created by sangheon on 2022/03/02.
//

import RxSwift

protocol RecordsRepository {
    func selectRecord() -> Single<SelectResponse>
}
