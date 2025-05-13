//
//  NotificationManager.swift
//  AMplify
//
//  Created by William on 08/05/25.
//

import Foundation
import UserNotifications
import CoreLocation

enum NotificationType {
    case reminderToStartTheJourney
    case reminderToClockOut
    case closeToTheAcademy
    
    var identifier : String {
        switch self {
        case .closeToTheAcademy:
            return "closeToTheAcademy"
        case .reminderToStartTheJourney:
            return "reminderToStartTheJourney"
        case .reminderToClockOut:
            return "reminderToClockOut"
        }
    }
    
    var title : String {
        switch self {
        case .closeToTheAcademy:
            return "You're Close!"
        case .reminderToStartTheJourney:
            return "Go to Apple Dev Academy!"
        case .reminderToClockOut:
            return "Clock Out!"
        }
    }
    
    var subtitle : String {
        switch self {
        case .closeToTheAcademy:
            return "Dont Forget to Clock In"
        case .reminderToStartTheJourney:
            return "It's time to start your journey!"
        case .reminderToClockOut:
            return "It's time to clock out!"
        }
    }
}

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
    
    func createNotificationContent(title: String, subtitle : String) -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        content.sound = .default
        content.interruptionLevel = .active
        return content
    }
    
    func createNotifDateComponent(hour : Int, weekday : Int) -> DateComponents {
        var comp = DateComponents()
        comp.hour = hour
        comp.minute = 0
        comp.weekday = weekday
        return comp
    }
    
    func scheduleNotification(notificationType : NotificationType, dateComponent: DateComponents, isRepeating: Bool, weekday: Int){
        deleteNotification(identifier: "\(notificationType.identifier)_\(weekday)")
        
        let notifContent = createNotificationContent(title: notificationType.title, subtitle: notificationType.subtitle)
        
        let trigger =  UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: isRepeating)
        
        let request = UNNotificationRequest(identifier: "\(notificationType.identifier)_\(weekday)", content: notifContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
        print("\(notificationType.identifier)_\(weekday) notification scheduled")
    }
    
    func deleteNotification(identifier: String){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    
    func shceduleNotificationForLocationADA(notificationType : NotificationType){
        let academyLocation = CLLocationCoordinate2D(latitude: LocationManager.appleDevAcademyLocation.coordinate.latitude, longitude: LocationManager.appleDevAcademyLocation.coordinate.longitude)
        
        let region = CLCircularRegion(center: academyLocation, radius: 150, identifier: "academyLocation")
        region.notifyOnEntry = true
        region.notifyOnExit = false
        
        let content = createNotificationContent(title: notificationType.title, subtitle: notificationType.subtitle)
        let trigger = UNLocationNotificationTrigger(region: region, repeats: true)
        
        let request = UNNotificationRequest(identifier: notificationType.identifier, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to schedule location notification: \(error)")
            }
        }
    }
}

