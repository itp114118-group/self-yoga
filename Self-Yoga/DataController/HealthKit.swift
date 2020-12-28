//
//  HealthKit.swift
//  Self-Yoga
//
//  Created by Jack on 27/12/2020.
//

import Foundation
import HealthKit

class HealthKit {
    
    var steps = [HKQuantitySample]()
    
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
    
    func requestHealthKitAuthorization(completionHandler:@escaping(String)->()) {
        let dataTypesToRead = NSSet(objects: stepsCount as Any)
        let result = healthStore?.requestAuthorization(toShare: nil, read: dataTypesToRead as? Set<HKObjectType>, completion: { (success, error) in
            if success {
                self.querySteps() { results in
                    print(results)
                }
            } else {
                print(error.debugDescription)
            }
        })
 
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
