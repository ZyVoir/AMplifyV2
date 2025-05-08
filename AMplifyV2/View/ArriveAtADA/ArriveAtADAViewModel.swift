//
//  ArriveAtADAViewModel.swift
//  AMplifyV2
//
//  Created by William on 08/05/25.
//

import Foundation
import SwiftUI

enum ArriveAtADAState : String {
    case new = "new"
    case completed = "completed"
    case ready = "ready"
    case active = "active"
}

enum ArriveAtADAAlertState {
    case notWorking
    case onTime
    case late
    case dayStreak(count : Int)
    
    var title: String {
        switch self {
        case .notWorking:
            return "Not Working Today"
        case .onTime:
            return "On Time!"
        case .late:
            return "Late!"
        case .dayStreak(let count):
            return "\(count) Day Streak!"
        }
    }
    
    var message: String {
        switch self {
        case .notWorking:
            return "Confirming this will not increase your streak"
        case .onTime, .late, .dayStreak:
            return "Complete your daily quests so your streak won’t reset!"
            
        }
    }
    
    var isShowingTextField : Bool {
        switch self {
        case .notWorking:
            return true
        default:
            return false
        }
    }
}

final class ArriveAtADAViewModel : ObservableObject {
   
    @Published var isShowSetup : Bool = false
    func showSetup() {
        isShowSetup = true
    }
    
    @Published var isShowAlert : Bool = false
    @Published private(set) var alertState : ArriveAtADAAlertState
    
    @Published private(set) var state: ArriveAtADAState {
        didSet {
            UserDefaults.standard.set(state.rawValue, forKey: "ArriveAtADAState")
        }
    }
    
    func showAlertNotWorking() {
        alertState = .notWorking
        isShowAlert = true
    }
    
    init() {
        self.state = ArriveAtADAState(rawValue: UserDefaults.standard.string(forKey: "ArriveAtADAState") ?? "new") ?? .new
        self.alertState = .notWorking
    }

    func notWorkingConfirmed(){
        updateState(state: .completed)
        dismissAlert()
    }
    
    func dismissAlert(){
        isShowAlert = false
    }
}

private extension ArriveAtADAViewModel {
    func updateState(state: ArriveAtADAState) {
        withAnimation {
            self.state = state
        }
    }
}
