//
//  TimerViewController.swift
//  iSleep
//
//  Created by Andrew Ke on 10/10/15.
//  Copyright © 2015 Andrew. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    @IBOutlet weak var weekday: UIDatePicker!
    @IBOutlet weak var weekend: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = NSUserDefaults.standardUserDefaults()
        weekday.setDate(defaults.valueForKey("Weekday") as! NSDate, animated: false)
        weekend.setDate(defaults.valueForKey("Weekend") as! NSDate, animated: false)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewWillDisappear(animated: Bool) {
        print(weekday.date)
        print(weekend.date)
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setValue(weekday.date, forKey: "Weekday");
        defaults.setValue(weekend.date, forKey: "Weekend");
        
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        
        let myCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        let myComponents = myCalendar.components(.Weekday, fromDate: NSDate())
        let weekDay = myComponents.weekday
        
        
        if (weekDay <= 6 && weekDay >= 2) // Weekday
        {
            print("Weekday")
            if (weekday.date.timeIntervalSinceNow < 0)
            {
                return
            }
            let notification = UILocalNotification()
            notification.fireDate = weekday.date
            notification.alertBody = "Good Morning!"
            notification.soundName = "ringer.caf"
            UIApplication.sharedApplication().scheduleLocalNotification(notification)

        }else // Weekend
        {
            print(NSDate())
            print("Weekend")
            
            print(weekday.date.timeIntervalSinceNow)
            
            /*if (weekday.date.timeIntervalSinceNow < 0)
            {
                return
            }*/

            let notification = UILocalNotification()
            //notification.fireDate = NSDate(timeInterval: -6 * 3600, sinceDate: weekend.date)
            notification.fireDate = weekend.date
            print(notification.fireDate)

            notification.alertBody = "Good Morning!"
            notification.soundName = "ringer.caf"
            print("Completed timer setup")
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
        }


        
        /*let notification = UILocalNotification()
        notification.fireDate = weekend.date
        notification.alertBody = "Good Morning!"
        notification.soundName = "sub.caf"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)*/
        
    }

}
