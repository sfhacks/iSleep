//
//  AppDelegate.swift
//  iSleep
//
//  Created by Andrew Ke on 10/10/15.
//  Copyright © 2015 Andrew. All rights reserved.
//

import UIKit

var main: ViewController!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        //UINavigationBar.appearance().barTintColor = UIColor.whiteColor()
        UINavigationBar.appearance().translucent = false
        
        //UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: UIFont(name: "Avenir", size: 16)!]
        if #available(iOS 8, *)
        {
            let pushSettings = UIUserNotificationSettings(forTypes: [UIUserNotificationType.Badge ,UIUserNotificationType.Sound ,UIUserNotificationType.Alert], categories: nil)
            application.registerUserNotificationSettings(pushSettings)
        }
        else
        {
            //UIApplication.sharedApplication().registerForRemoteNotificationTypes(([UIUserNotificationType.Alert,UIUserNotificationType.Badge,UIUserNotificationType.Sound])
        }

        return true
    }
    
    @available(iOS 8.0, *)
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        //application.registerForRemoteNotifications()
    }
    
    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let token = deviceToken.description
        print("Notifications token received : \(token)")
    }
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        print("Error registering for notifications: \(error)")
    }
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, withResponseInfo responseInfo: [NSObject : AnyObject], completionHandler: () -> Void) {
        print("Stopping!")
        main.stopTimer()
        if (UIApplication.sharedApplication().applicationState == UIApplicationState.Active)
        {
            print("Creating artificial alert to simulate in app alarm")
            let rootVC = UIApplication.sharedApplication().keyWindow?.rootViewController
            
            if #available(iOS 8.0, *) {
                let alert = UIAlertController(title: "Alarm", message: "Good Morning!", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "Turn Off", style: .Default, handler: nil))
                rootVC!.presentViewController(alert, animated: true, completion: nil)
            } else {
                let alertView = UIAlertView(title: "Alarm", message: "Good Morning", delegate: nil, cancelButtonTitle: "Turn Off");
                alertView.alertViewStyle = .Default
                alertView.show()
            }
            
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

