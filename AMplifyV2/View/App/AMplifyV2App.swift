//
//  AMplifyV2App.swift
//  AMplifyV2
//
//  Created by William on 05/05/25.
//

import SwiftUI

@main
struct AMplifyV2App: App {
    @StateObject private var locationManager : LocationManager = LocationManager()
    @StateObject private var notificationManager : NotificationManager = NotificationManager()
    
    @AppStorage("lastCheckedDate") private var lastCheckedDate: String = ""
    
    init() {
        checkForNewDay()
    }
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environmentObject(locationManager)
                .environmentObject(notificationManager)
                .onAppear {
                    notificationManager.requestNotificationPermission()
                }
        }
    }
    
    func checkForNewDay() {
        let today = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
        let weekday = Calendar.current.component(.weekday, from: Date())
        
        if today != lastCheckedDate {
            lastCheckedDate = today
        
            if !(weekday == 1 || weekday == 7) {
                // New day and weekday
                // Set isTodayDoneStreak to false
                UserDefaults.standard.set(false, forKey: "isTodayDoneStreak")
                // Set completedQuest to 0
                UserDefaults.standard.set(0, forKey: "completedQuest")
                
                // every state to ready if they're completed, otherwise leave it
                
                // third state
                if UserDefaults.standard.string(forKey: "ArriveAtADAState") == "Completed" {
                    UserDefaults.standard.set("Ready", forKey: "ArriveAtADAState")
                }
            }
        }
    }
}
