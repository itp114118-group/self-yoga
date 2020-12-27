//
//  HealthKit.swift
//  Self-Yoga
//
//  Created by Jack on 27/12/2020.
//

import Foundation
import HealthKit

class HealthKit {
    
    class var sharedInstance: HealthKit {
        struct Singleton {
            static let instance = HealthKit()
        }
        
        return Singleton.instance
    }
    
    let healthStore: HKHealthStore? = {
        if HKHealthStore.isHealthDataAvailable() {
            return HKHealthStore()
        } else {
            return nil
        }
    }()
    
    let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    
    let stepsUnit = HKUnit.count()
    
    func requestHealthKitAuthorization(completionHandler: @escaping (Bool, Error?) -> ()) {
        let dataTypesToRead = NSSet(objects: stepsCount as Any)
        healthStore?.requestAuthorization(toShare: nil, read: dataTypesToRead as? Set<HKObjectType>) { (success, error) in
            completionHandler(success, error)
        }
    }
    
    func querySteps(completionHandler:@escaping([HKQuantitySample])->()) {
        let sampleQuery = HKSampleQuery(sampleType: stepsCount!,
                                        predicate: nil,
                                        limit: 100,
                                        sortDescriptors: nil)
        { (query, results, error) in
            if let results = results as? [HKQuantitySample] {
                completionHandler (results)
            }
        }
        
        healthStore?.execute(sampleQuery)
    }
    
}
