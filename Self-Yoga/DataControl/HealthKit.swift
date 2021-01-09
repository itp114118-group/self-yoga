//
//  HealthKit.swift
//  Self-Yoga
//
//  Created by Jack on 27/12/2020.
//

import Foundation
import HealthKit

struct HealthKit {
    
    static var sharedInstance: HealthKit {
        struct Singleton {
            static let instance = HealthKit()
        }
        return Singleton.instance
    }
    
    private enum HealthkitSetupError: Error {
        case notAvailableOnDevice
        case dataTypeNotAvailable
    }
    
    // ask health app permission
    func requestHealthKitAuthorization(completion: @escaping (Bool, Error?) -> Swift.Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false, HealthkitSetupError.notAvailableOnDevice)
            return
        }
        
        guard let stepsCount = HKObjectType.quantityType(forIdentifier: .stepCount) else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        var healthKitTypesToWrite = Set<HKSampleType>()
        healthKitTypesToWrite.insert(stepsCount)
        
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: nil) { (success, error) in
            completion(success, error)
        }
        
    }
    
    // save user steps func
    func saveSteps(stepsCountValue: Int,
                   date: Date,
                   completion: @escaping (Error?) -> Swift.Void) {
        
        guard let stepCountType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            fatalError("Step Count Type is no longer available in HealthKit")
        }
        
        let stepsCountUnit:HKUnit = HKUnit.count()
        let stepsCountQuantity = HKQuantity(unit: stepsCountUnit,
                                            doubleValue: Double(stepsCountValue))
        
        let stepsCountSample = HKQuantitySample(type: stepCountType,
                                                quantity: stepsCountQuantity,
                                                start: date,
                                                end: date)
        
        HKHealthStore().save(stepsCountSample) { (success, error) in
            if let error = error {
                completion(error)
                print("Error Saving Steps Count Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Steps Count Sample")
            }
        }
        
    }
    
}

