//
//  AMplifyV2App.swift
//  AMplifyV2
//
//  Created by William on 05/05/25.
//

import SwiftUI

@main
struct AMplifyV2App: App {
//    @StateObject private var locationManager : LocationManager = LocationManager()
    @StateObject private var notificationManager : NotificationManager = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
//                .environmentObject(locationManager)
                .environmentObject(notificationManager)
        }
    }
}
