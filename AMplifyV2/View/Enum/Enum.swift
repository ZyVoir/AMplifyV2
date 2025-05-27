//
//  Enum.swift
//  AMplifyV2
//
//  Created by William on 08/05/25.
//

import Foundation
import SwiftUI

enum Icons: String {
    case alarm = "alarm.fill"
    case morningRoutine = "sun.horizon.fill"
    case arriveAtADA = "apple.logo"
    case streakActive = "flame.fill"
    case streakInactive = "flame"
    case questCompleted = "flag.pattern.checkered"
    case morningSession = "sun.horizon"
    case afternoonSession = "sun.max"
    case onboarding = "questionmark.circle"
    case questDone = "checkmark.circle.fill"
    case setting = "gearshape.fill"
    case checklist = "checkmark"
}

enum QuestState : CaseIterable {
    case new
    case completed
    case ready
    case active
    
    var value : String {
        switch self {
        case .new:
            return "New"
        case .completed:
            return "Completed"
        case .ready:
            return "Ready"
        case .active:
            return "Active"
        }
    }
    
    init(value : String) {
        switch value {
        case "New":
            self = .new
        case "Completed":
            self = .completed
        case "Ready":
            self = .ready
        case "Active":
            self = .active
        default:
            self = .new
        }
    }
}

enum LearnerSessionType {
    case morning
    case afternoon
    
    var title : String {
        switch self {
        case .morning:
            return "Morning"
        case .afternoon:
            return "Afternoon"
        }
    }
   
    var time : Date {
        switch self {
        case .morning:
            return IOHelper.shared.parseStringToDate("23:20:00")
        case .afternoon:
            return IOHelper.shared.parseStringToDate("13:00:00")
        }
    }
    
    var icon : String {
        switch self {
        case .morning:
            return Icons.morningSession.rawValue
        case .afternoon:
            return Icons.afternoonSession.rawValue
        }
    }
    
    var bg : LinearGradient {
        switch self {
        case .morning:
            return LinearGradient.morningSession
        case .afternoon:
            return LinearGradient.afternoonSession
        }
    }
    
    init(value rawValue : String) {
        switch rawValue {
        case "Morning":
            self = .morning
        case "Afternoon":
            self = .afternoon
        default:
            self = .morning
        }
    }
}
