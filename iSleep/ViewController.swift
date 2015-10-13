//
//  ViewController.swift
//  iSleep
//
//  Created by Andrew Ke on 10/10/15.
//  Copyright © 2015 Andrew. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    
    var startDate: NSDate!
    var timer: NSTimer!
    var sleeping: Bool = false;
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self;
        print("Test");
        
        let defaults = NSUserDefaults.standardUserDefaults()
        if (defaults.valueForKey("Weekday") == nil)
        {
            print("Creating default values")
            defaults.setObject(NSDate(), forKey: "Weekday");
            defaults.setObject(NSDate(), forKey: "Weekend");
            defaults.setObject([10.0, 5.0, 6.5, 7.0, 10.0, 12.0, 0.0], forKey: "Sleep")
            defaults.synchronize();
        }
        
        if (defaults.valueForKey("Sleep") == nil)
        {
            defaults.setObject([10.0, 5.0, 6.5, 7.0, 10.0, 12.0, 0.0], forKey: "Sleep")
            defaults.synchronize()
        }
        
        timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: Selector("tick"), userInfo: nil, repeats: true)
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = NSDateFormatterStyle.LongStyle
        formatter.timeStyle = .NoStyle
        
        date.text = formatter.stringFromDate(NSDate())
    }
    
    
    override func viewDidAppear(animated: Bool) {
        print(NSUserDefaults.standardUserDefaults().description);
        tableView.reloadData()
        
        print(NSUserName())
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tick()
    {
        if (sleeping)
        {
            let seconds: Int = Int(NSDate().timeIntervalSinceDate(startDate))
            label.text = String(format: "Sleep Time: %02d:%02d:%02d", Int(seconds/3600), Int((seconds%3600)/60) , Int(seconds%60))
        }
    }

    @IBAction func startStopPresssed(sender: UIButton) {
        if (sender.titleLabel?.text == "Start!")
        {
            sender.setTitle("Stop", forState: UIControlState.Normal)
            sender.backgroundColor = UIColor.redColor()
            startDate = NSDate()
            sleeping = true
            
        }else
        {
            sender.setTitle("Start!", forState: UIControlState.Normal)
            sender.backgroundColor = UIColor.greenColor()
            print(NSDate().timeIntervalSinceDate(startDate))
            sleeping = false
            
            let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let myComponents = myCalendar.components(.Weekday, fromDate: NSDate())
            let weekDay = myComponents.weekday
            
            let defaults = NSUserDefaults.standardUserDefaults()
            var sleepArray = defaults.valueForKey("Sleep") as! [Double]
            sleepArray[weekDay-1] = NSDate().timeIntervalSinceDate(startDate)/3600
            defaults.setValue(sleepArray, forKey: "Sleep")
            defaults.synchronize()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "hh:mm aaa"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! AlarmTVC;
        if (indexPath.row == 0)
        {
            cell.title.text = "Weekdays"
            let date = defaults.valueForKey("Weekday") as! NSDate
            cell.time.text = formatter.stringFromDate(date)
        }else
        {
            cell.title.text = "Weekends"
            let date = defaults.valueForKey("Weekend") as! NSDate
            cell.time.text = formatter.stringFromDate(date)
        }
        cell.backgroundColor = UIColor(white: CGFloat(1.0), alpha: CGFloat(0.5))
        return cell;
    }
    
    

}

