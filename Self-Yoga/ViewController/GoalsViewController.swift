//
//  GoalsViewController.swift
//  Self-Yoga
//
//  Created by itst on 18/12/2020.
// yuki


import UIKit
import Charts
import HealthKit

class GoalsViewController: UIViewController {
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    var barChart = BarChartView()
    var pieChart = PieChartView()
    
    let healthKit = HealthKit.sharedInstance
    let healthKitController = HealthKitController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
        barChart.delegate = self
        
        // add Health Kit data
        healthKitController.addData(caloriesBurned: 8.0, minutes: 60.0)
   
        // ask user health app permission
        healthKit.requestHealthKitAuthorization { (result, error) in
            if result {
                print("Auth ok")
            } else {
                print("Auth denied")
            }
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showBarChartView()
        showPieChartView()
    
    }
    
}

extension GoalsViewController: ChartViewDelegate {
    
    func showBarChartView() {
        barChart.frame = CGRect(x: 0, y: 0, width: self.barChartView.frame.size.width,
                                height: self.barChartView.frame.size.height)
        
        barChartView.addSubview(barChart)
        
        let colors = [UIColor(named:"B6E9C1")]
        let set = BarChartDataSet(entries: healthKitController.coloriesArray)
        set.colors = colors as! [NSUIColor]
        let data = BarChartData(dataSet: set)
        data.barWidth = 0.2
        barChart.data = data
        
        // Don't show data
        barChart.data?.setDrawValues(false)
        
        // Animation
        barChart.animate(xAxisDuration: 2.0)
        
        // UI design
        barChartView.backgroundColor = UIColor(named: "003659")
        
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        barChart.leftAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        barChartView.layer.cornerRadius = 20
        barChartView.layer.masksToBounds = true
        
    }
    
    func showPieChartView() {
        
        pieChart.frame = CGRect(x: 0, y: 0, width: self.pieChartView.frame.size.width,
                                height: self.pieChartView.frame.size.height)
        
        pieChartView.addSubview(pieChart)
        
        var entries = [PieChartDataEntry]()
        
        for i in 0..<10 {
            entries.append(PieChartDataEntry(value: Double(i), data: Double(i)))
        }
        
        let colors = [UIColor(named:"B6E9C1"), UIColor(named:"003659")]
        let set = PieChartDataSet(entries: entries)
        set.colors = colors as! [NSUIColor]
        pieChart.data = PieChartData(dataSet: set)
        
        //        pieChart.data?.setDrawValues(false)
        
        // Animation
        pieChart.animate(xAxisDuration: 2.0)
        
        // UI design
        pieChartView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        pieChartView.layer.cornerRadius = 20
        pieChartView.layer.masksToBounds = true
        
        // pie chart no gap
        pieChart.holeRadiusPercent = 0.0
        pieChart.transparentCircleRadiusPercent = 0.0
        pieChart.drawHoleEnabled = false
        
    }
    
}
