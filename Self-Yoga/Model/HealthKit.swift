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
        
        guard let caloriesBurnedCount = HKObjectType.quantityType(forIdentifier: .activeEnergyBurned) else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        guard let mindfulCount = HKObjectType.categoryType(forIdentifier: .mindfulSession) else {
            completion(false, HealthkitSetupError.dataTypeNotAvailable)
            return
        }
        
        var healthKitTypesToWrite = Set<HKSampleType>()
        healthKitTypesToWrite.insert(caloriesBurnedCount)
        healthKitTypesToWrite.insert(mindfulCount)
        
        HKHealthStore().requestAuthorization(toShare: healthKitTypesToWrite, read: nil) { (success, error) in
            completion(success, error)
        }
        
    }
    
    func saveCaloriesBurned(caloriesBurnedValue: Double,
                            date: Date,
                            completion: @escaping (Error?) -> Swift.Void) {
        
        guard let caloriesBurnedType = HKQuantityType.quantityType(forIdentifier: .activeEnergyBurned) else {
            fatalError("Calories Burned Type is no longer available in HealthKit")
        }
        
        let caloriesBurnedUnit: HKUnit = HKUnit.calorie()
        let caloriesBurnedQuantity = HKQuantity(unit: caloriesBurnedUnit,
                                          doubleValue: caloriesBurnedValue * 1000)
        
        let caloriesBurnedSample = HKQuantitySample(type: caloriesBurnedType,
                                              quantity: caloriesBurnedQuantity,
                                              start: date,
                                              end: date)
        
        HKHealthStore().save(caloriesBurnedSample) { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Calories Burned Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Calories Burned Sample")
            }
        }
        
    }

    func saveMindfullAnalysis(startTime: Date, endTime: Date,
                              completion: @escaping (Error?) -> Swift.Void) {
        
        guard let mindfulType = HKObjectType.categoryType(forIdentifier: .mindfulSession) else {
            fatalError("Mindful Minutes Type is no longer available in HealthKit")
        }
        
        // Create a mindful session with the given start and end time
        let mindfullSample = HKCategorySample(type: mindfulType, value: 0, start: startTime, end: endTime)

        // Save it to the health store
        HKHealthStore().save(mindfullSample, withCompletion: { (success, error) in
            
            if let error = error {
                completion(error)
                print("Error Saving Mindful Minutes Sample: \(error.localizedDescription)")
            } else {
                completion(nil)
                print("Successfully saved Mindful Minutes Sample")
            }
        })
    }
    
    
}

