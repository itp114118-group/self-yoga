//
//  GoalsViewController.swift
//  Self-Yoga
//
//  Created by itst on 18/12/2020.
//


import UIKit
import Charts

class GoalsViewController: UIViewController, ChartViewDelegate {
    
    var pieChart = PieChartView()
    var barChart = BarChartView()
    
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChart.delegate = self
        barChart.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        showBarChartView()
        showPieChartView()
    }
    
    func showBarChartView() {
        barChart.frame = CGRect(x: 0, y: 0, width: self.barChartView.frame.size.width,
                                height: self.barChartView.frame.size.height)
        
        barChartView.addSubview(barChart)
        
        var entries = [BarChartDataEntry]()
        
        for i in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(i), y: Double(i)))
        }
        
        let colors = [UIColor(named:"B6E9C1")]
        let set = BarChartDataSet(entries: entries)
        set.colors = colors as! [NSUIColor]
        var data = BarChartData(dataSet: set)
        data.barWidth = 0.2
        barChart.data = data
        
        // Don't show data
        barChart.data?.setDrawValues(false)
        
        barChartView.backgroundColor = UIColor(named: "003659")
        
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        barChart.leftAxis.labelTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        barChart.animate(xAxisDuration: 2.0)
        
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
        
        pieChart.animate(xAxisDuration: 2.0)
        
        pieChartView.backgroundColor = UIColor(named: "003659")
        
        pieChartView.layer.cornerRadius = 20
        pieChartView.layer.masksToBounds = true
        
        // pie chart no gap
        pieChart.holeRadiusPercent = 0.0
        pieChart.transparentCircleRadiusPercent = 0.0
        pieChart.drawHoleEnabled = false
        
    }

}
