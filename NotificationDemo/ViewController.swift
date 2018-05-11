//
//  ViewController.swift
//  NotificationDemo
//
//  Created by Praveen on 09/05/18.
//  Copyright © 2018 Praveen. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checkNotificationAuthorization()
        createNotification()
    }
    
    
    func createNotification() {
        
        //1 content
        let content = UNMutableNotificationContent()
        content.title = "Codilar Title"
        content.subtitle = "Magento based ecommarece companmy"
        content.body = "Swift uses Automatic Reference Counting (ARC) to track and manage your app’s memory usage. In most cases, this means that memory management “just works” in Swift, and you do not need to think about memory management yourself"
        content.sound = UNNotificationSound.default()
        
        
        //2 trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
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
    
    func checkNotificationAuthorization() {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound]) {
                (granted, error) in
                if granted {
                    print("Notification Permission granted")
                } else {
                    print("ERROR: ", error?.localizedDescription ?? "ERROR")
                }
        }
    }

    
}

