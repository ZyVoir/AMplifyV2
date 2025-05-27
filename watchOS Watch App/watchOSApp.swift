//
//  watchOSApp.swift
//  watchOS Watch App
//
//  Created by William on 23/05/25.
//

import SwiftUI

@main
struct watchOS_Watch_AppApp: App {
    
    var viewModel : WatchArriveAtADAViewModel = WatchArriveAtADAViewModel()
    var watchConnector = WatchToIOSConnectorManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(viewModel)
                .environment(watchConnector)
                
        }
    }
}
