//
//  AMplfyAppIntent.swift
//  AMplifyV2
//
//  Created by William on 15/05/25.
//

import Foundation
import AppIntents

struct AMplfyAppIntent: AppShortcutsProvider {
    
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: GetTimeLeftIntent(),
            phrases: [
                "How much time left before academy in \(.applicationName)",
                "Time left until academy with \(.applicationName)",
                "Get academy countdown with \(.applicationName)",
                "Academy time left with \(.applicationName)"
            ],
            shortTitle: "Time Left To Academy",
            systemImageName: "apple.logo"
        )
    }
}
