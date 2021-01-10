//
//  HealthKitController.swift
//  Self-Yoga
//
//  Created by Jack on 9/1/2021.
//

import Foundation
import Charts

class HealthKitController {
    
    var healthKit = HealthKit()
    var date = Date()
    var coloriesArray = [BarChartDataEntry]()
    
    func addData(caloriesBurned: Double, minutes: Double) {
        healthKit.saveCaloriesBurned(caloriesBurnedValue: Double(caloriesBurned), date: date) { (error) in
            self.coloriesArray.append(BarChartDataEntry(x: Double(caloriesBurned), y: Double(caloriesBurned)))
        }
        healthKit.saveMindfullAnalysis(startTime: date, endTime: date.addingTimeInterval(minutes * 60.0)) { (error) in
            
        }
    }
}
