//
//  GraphViewController.swift
//  iSleep
//
//  Created by Andrew Ke on 10/10/15.
//  Copyright © 2015 Andrew. All rights reserved.
//  Blah

import UIKit

class GraphViewController: UIViewController {
    @IBOutlet weak var barChartView: BarChartView!
    var months: [String]!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        months = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
        let data = NSUserDefaults.standardUserDefaults().valueForKey("Sleep") as! [Double]
        print(data)
        setChart(months, values: data)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        barChartView.xAxis.labelPosition = .Bottom
        
        let ll = ChartLimitLine(limit: 8.5, label: "Healthy Average")
        ll.lineColor = UIColor.greenColor()
        ll.valueTextColor = UIColor.greenColor()
        barChartView.rightAxis.addLimitLine(ll)
        let average = values.reduce(0) { $0 + $1 } / Double(values.count)
        let ll2 = ChartLimitLine(limit: average, label: "Your Average")
        ll2.valueTextColor = UIColor.redColor()
        barChartView.rightAxis.addLimitLine(ll2)
        barChartView.rightAxis.labelTextColor = UIColor.whiteColor()
        barChartView.gridBackgroundColor = UIColor.clearColor()
        barChartView.leftAxis.labelTextColor = UIColor.whiteColor()
        
        
        barChartView.noDataText = "You need to provide data for the chart."
        barChartView.descriptionText = ""
        barChartView.userInteractionEnabled = false;
        //print()
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Hours Slept")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        barChartView.data = chartData
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
