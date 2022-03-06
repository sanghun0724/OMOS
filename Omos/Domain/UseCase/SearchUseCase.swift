//
//  SearchUseCase.swift
//  Omos
//
//  Created by sangheon on 2022/03/06.
//

import Foundation
import RxSwift


class SearchUseCase {
    private let searchRepository:SearchRepository
    
  
    init(searchRepository:SearchRepository) {
        self.searchRepository = searchRepository
    }
}
