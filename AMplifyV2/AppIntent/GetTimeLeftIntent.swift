//
//  GetTimeLeftIntent.swift
//  AMplifyV2
//
//  Created by William on 15/05/25.
//

import AppIntents

struct GetTimeLeftIntent: AppIntent {
    
    static var title: LocalizedStringResource = "Get Time Info"
    
    static var description = IntentDescription("Returns time left until clock in time in academy")
    
    func perform() async throws -> some IntentResult & ProvidesDialog {
        
        let sessionSelection = LearnerSessionType(value: UserDefaults.standard.string(forKey: "LearnerSessionType") ?? "Morning")
        let state = QuestState(value: UserDefaults.standard.string(forKey: "ArriveAtADAState") ?? "New")
        
        if state == .new {
            return .result(dialog: "You haven't set your session in application settings. Please set your session in application settings and try again.")
        }
        else if state == .completed {
            return .result(dialog: "You have already clock in. See you Tomorrow!")
        }
        
        // if active or ready, can access this
        let timeLeft: String = IOHelper.shared.timeDifferencePhrase(from: Date(), to: sessionSelection.time)
        
        if Date() > sessionSelection.time {
            return .result(dialog: "The Academy has started, You're late by \(timeLeft)")
        }
        
        return .result(dialog: "You have \(timeLeft) left before the academy starts!")
    }
    
}

