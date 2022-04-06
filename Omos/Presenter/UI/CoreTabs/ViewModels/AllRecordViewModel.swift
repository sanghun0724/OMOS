//
//  AllRecordViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import Foundation
import RxSwift


class AllRecordViewModel:BaseViewModel {
    
    let loading = BehaviorSubject<Bool>(value:false)
    let selectRecords = BehaviorSubject<SelectResponse>(value:.init(aLine: [], ost: [], lyrics: [], free: [], story: []))
    var currentSelectRecords:SelectResponse = .init(aLine: [], ost: [], lyrics: [], free: [], story: [])
    let errorMessage = BehaviorSubject<String?>(value: nil)
    let usecase:RecordsUseCase
    
    
    func selectRecordsShow() {
        loading.onNext(true)
        usecase.selectRecord()
            .subscribe({ [weak self] event in
                self?.loading.onNext(false)
                switch event {
                case .success(let data):
                    print("success")
                    self?.currentSelectRecords = data
                    self?.removeReportedRecord()
                case .failure(let error):
                    self?.errorMessage.onNext(error.localizedDescription)
                }
            }).disposed(by: disposeBag)
    }
    
    private func removeReportedRecord() {
        DispatchQueue.global().sync {
            var stack = currentSelectRecords.aLine
            currentSelectRecords.aLine = stack.filter{ !Account.currentReportRecordsId.contains( $0.recordID)}
            
            stack = currentSelectRecords.free
            currentSelectRecords.free = stack.filter{ !Account.currentReportRecordsId.contains( $0.recordID)}
            
            stack = currentSelectRecords.ost
            currentSelectRecords.ost = stack.filter{ !Account.currentReportRecordsId.contains( $0.recordID)}
            
            stack = currentSelectRecords.lyrics
            currentSelectRecords.lyrics = stack.filter{ !Account.currentReportRecordsId.contains( $0.recordID)}
            
            stack = currentSelectRecords.story
            currentSelectRecords.story = stack.filter{ !Account.currentReportRecordsId.contains( $0.recordID)}
        }
        DispatchQueue.global().sync {
            self.selectRecords.onNext(.init(aLine: [], ost: [], lyrics: [], free: [], story: []))
        }
    }
    
    func numberofSections() -> Int {
        return 5
    }
    
    
    init(usecase:RecordsUseCase) {
        self.usecase = usecase
        super.init()
    }
    
    
}
