//
//  DataController.swift
//  Self-Yoga
//
//  Created by Jack on 24/12/2020.
//

import Foundation

class DataController {
    
    var dataArray = [YogaSet]()
    
    init() {
        
    }
   
    func count() -> Int {
        return dataArray.count
    }
    
    func yogaSet(at index: Int) -> YogaSet {
        return dataArray[index]
    }
    
}
