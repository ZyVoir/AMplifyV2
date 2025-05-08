//
//  NotificationManager.swift
//  AMplify
//
//  Created by William on 08/05/25.
//

import Foundation
import UserNotifications

class NotificationManager : ObservableObject {
    
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { _, err in
            if let err = err {
                print("Failed to request notification permission: \(err)")
            }
            else {
                print("Successfully requested notification permission")
            }
        }
    }
    
    func scheduleNotification(title: String, subtitle : String, sound : String, dateComponent: DateComponents, identifier: String, isRepeating: Bool){
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: sound))
        
        let trigger =  UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: isRepeating)
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 61, repeats: false)
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        print("\(identifier) notification scheduled")
    }
}

