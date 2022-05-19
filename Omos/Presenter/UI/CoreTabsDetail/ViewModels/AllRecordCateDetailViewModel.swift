//
//  AllRecordDetailViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/03/03.
//

import Foundation
import RxSwift

typealias LyricsCellConfig = TableCellConfigurator<AllrecordLyricsTableCell, RecordResponse>
typealias ShortCellConfig = TableCellConfigurator<AllRecordCateShortDetailCell, RecordResponse>
typealias LongCellConfig = TableCellConfigurator<AllRecordCateLongDetailCell, RecordResponse>

class AllRecordCateDetailViewModel: BaseViewModel {
    let recentFilter = PublishSubject<Bool>()
    let likeFilter = PublishSubject<Bool>()
    let randomFilter = PublishSubject<Bool>()
    let loading = BehaviorSubject<Bool>(value: false)
    let cateRecords = BehaviorSubject<[RecordResponse]>(value: [])
    var currentCateRecords: [RecordResponse] = []
    let reportState = PublishSubject<Bool>()
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let usecase: RecordsUseCase
    var items: [CellConfigurator] = []

    func selectRecordsShow(type: CateType, postId: Int?, size: Int, sort: String, userid: Int) {
        loading.onNext(true)
        usecase.cateFetch(type: type, postId: postId, size: size, sort: sort, userid: userid)
            .map {
                $0.filter { !Account.currentReportRecordsId.contains($0.recordID) }
            }
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    self?.currentCateRecords += data
                    self?.appendDataToItems(type: type)
                    self?.cateRecords.onNext(data)
                case .failure(let error):
                    print(error.localizedDescription)
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    private func appendDataToItems(type: CateType) {
        if type == .lyrics {
            var tmpArr: [LyricsCellConfig] = []
            for record in currentCateRecords {
                tmpArr.append(.init(item: record))
            }
            items.append(contentsOf: tmpArr)
        } else if type == .aLine {
            var tmpArr: [ShortCellConfig] = []
            for record in currentCateRecords {
                tmpArr.append(.init(item: record))
            }
            items.append(contentsOf: tmpArr)
        } else {
            var tmpArr: [LongCellConfig] = []
            for record in currentCateRecords {
                tmpArr.append(.init(item: record))
            }
            items.append(contentsOf: tmpArr)
        }
    }
    
    func numberofRows() -> Int {
        currentCateRecords.count
    }

    private func removeReportedRecord() {
        var stack = currentCateRecords
        DispatchQueue.global().sync {
            for idx in 0..<currentCateRecords.count {
                if Account.currentReportRecordsId.contains(currentCateRecords[idx].recordID) {
                    stack.remove(at: idx)
                }
            }
            currentCateRecords = stack
        }
        DispatchQueue.global().sync {
            self.cateRecords.onNext(stack)
        }
    }

    // Interation
    func saveScrap(postId: Int, userId: Int) {
        usecase.saveScrap(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }

    func deleteScrap(postId: Int, userId: Int) {
        usecase.deleteScrap(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }

    func saveLike(postId: Int, userId: Int) {
        usecase.saveLike(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }

    func deleteLike(postId: Int, userId: Int) {
        usecase.deleteLike(postId: postId, userId: userId)
            .subscribe({ event in
                print(event)
            }).disposed(by: disposeBag)
    }

    func reportRecord(postId: Int) {
        usecase.reportRecord(postId: postId)
            .subscribe({ [weak self] event in
                switch event {
                case .success(let data):
                    self?.reportState.onNext(data.state)
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }

    init(usecase: RecordsUseCase) {
        self.usecase = usecase
        super.init()
    }
}
