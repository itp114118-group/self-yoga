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
    var exerciseTime = [HKQuantitySample]()
    
    let stepsCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)
    let dataCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)
    
    // No Ideas
    let stepsUnit = HKUnit.count()
    
    // get data from last 7 days
//    let predicate = HKQuery.predicateForSamples(withStart: Date() - 7 * 24 * 60 * 60, end: Date(), options: [])
    
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
    
    // ask health app permission
    func requestHealthKitAuthorization() {
        var readTypes = Set<HKObjectType>()
        readTypes.insert(stepsCount!)
        readTypes.insert(dataCount!)
        
        healthStore?.requestAuthorization(toShare: nil, read: readTypes, completion: { (success, error) in
            if success {
                self.querySteps()
                self.queryExerciseTime()
            } else {
                print(error.debugDescription)
            }
        })
 
    }
    
    // get steps from Health app
    func querySteps() {
        let sampleQuery = HKSampleQuery(sampleType: stepsCount!,
                                        predicate: nil,
                                        limit: 100,
                                        sortDescriptors: nil)
        { (query, results, error) in
            if let results = results as? [HKQuantitySample] {
                self.steps = results

            }
        }
        
        healthStore?.execute(sampleQuery)
    }
    
    // get Exercise Time from Health app
    func queryExerciseTime() {
        let sampleQuery = HKSampleQuery(sampleType: dataCount!,
                                        predicate: nil,
                                        limit: 100,
                                        sortDescriptors: nil)
        { (query, results, error) in
            if let results = results as? [HKQuantitySample] {
                self.exerciseTime = results
            }
        }
        
        healthStore?.execute(sampleQuery)
    }
    
}
