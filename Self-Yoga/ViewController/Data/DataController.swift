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
        let yogaSet1 = YogaSet(title: "Beginner Full Body Flexibility", subtitle: "6 Workout")
        let yogaSet2 = YogaSet(title: "Beginner Full Body Vinyasa Flow", subtitle: "6 Workout")
        dataArray.append(yogaSet1)
        dataArray.append(yogaSet2)
    }
    
    func count() -> Int {
        return dataArray.count
    }
    
    func yogaSet(at index: Int) -> YogaSet {
        return dataArray[index]
    }
    
}
