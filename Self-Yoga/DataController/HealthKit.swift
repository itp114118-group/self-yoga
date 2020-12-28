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
 
    var readTypes = Set<HKObjectType>()
    
    // get data from last 7 days
//    let predicate = HKQuery.predicateForSamples(withStart: Date() - 7 * 24 * 60 * 60, end: Date(), options: [])
    
    init() {
        requestHealthKitAuthorization()
    }
    
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
    let dataCount = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.appleExerciseTime)
    
    let stepsUnit = HKUnit.count()
    
    // ask health app permission
    func requestHealthKitAuthorization() {
        readTypes.insert(stepsCount!)
        readTypes.insert(dataCount!)
        
        healthStore?.requestAuthorization(toShare: nil, read: readTypes, completion: { (success, error) in
            if success {
                self.querySteps() { results in
                    self.steps = results
                }
                
                self.queryExerciseTime() { results in
                    self.exerciseTime = results
                }
            } else {
                print(error.debugDescription)
            }
        })
 
    }
    
    // get steps from Health app
    func querySteps(completionHandler:@escaping([HKQuantitySample])->()) {
        let sampleQuery = HKSampleQuery(sampleType: stepsCount!,
                                        predicate: nil,
                                        limit: 100,
                                        sortDescriptors: nil)
        { (query, results, error) in
            if let results = results as? [HKQuantitySample] {
                completionHandler(results)
            }
        }
        
        healthStore?.execute(sampleQuery)
    }
    
    // get Exercise Time from Health app
    func queryExerciseTime(completionHandler:@escaping([HKQuantitySample])->()) {
        let sampleQuery = HKSampleQuery(sampleType: dataCount!,
                                        predicate: nil,
                                        limit: 100,
                                        sortDescriptors: nil)
        { (query, results, error) in
            if let results = results as? [HKQuantitySample] {
                completionHandler(results)
            }
        }
        
        healthStore?.execute(sampleQuery)
    }
    
}
