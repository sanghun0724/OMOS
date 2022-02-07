//
//  AllRecordViewModel.swift
//  Omos
//
//  Created by sangheon on 2022/02/06.
//

import Foundation

struct test {
    let testThing:[String]
}


class AllRecordViewModel {
    
    private(set) var model:[test] = []
    
    func viewDidLoad() {
        model.append(test(testThing: ["12345"]))
        model.append(test(testThing: ["4234"]))
        model.append(test(testThing: ["42342222"]))
        model.append(test(testThing: ["145"]))
        model.append(test(testThing: ["878989789789"]))
    }
    
    
    func numberofSection() -> Int {
        return 5 // 5 <- 카테 종류
    }
    
    
    
}
