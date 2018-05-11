//
//  AppDelegate.swift
//  NotificationDemo
//
//  Created by Praveen on 09/05/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
}

extension AppDelegate : UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert, .badge])
        print(notification.request.identifier)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        //receieving notification here from inactive to (tap to open) active stat
        createNotification(response.notification.request.content.userInfo)
    }
    
    func createNotification(_ userInfo: [AnyHashable : Any]) {
        
        //1 content
        let content = UNMutableNotificationContent()
        content.title = userInfo["title"]! as! String
        content.subtitle = userInfo["subtitle"]! as! String
        content.body = userInfo["body"]! as! String
        content.sound = UNNotificationSound.default()
        content.userInfo = userInfo
        
        //2 trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
        
        //3 request
        let request = UNNotificationRequest(identifier: "someID", content: content, trigger: trigger)
        
        //4 add notitfication to queue
        UNUserNotificationCenter.current()
            .add(request) { (error) in
                if error != nil {
                    print("Some error occured: ", error?.localizedDescription ?? "")
                }else {
                    print("Notification will show")
                }
        }
        
    }
    
}


