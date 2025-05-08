//
//  HomeViewModel.swift
//  AMplifyV2
//
//  Created by William on 07/05/25.
//

import Foundation
import Observation
import SwiftUI

enum homeViewSelectionState {
    case alarm
    case morningRoutine
    case arriveAtADA
    
    var selectedIndex : Int {
        switch self {
        case .alarm:
            return 0
        case .morningRoutine:
            return 1
        case .arriveAtADA:
            return 2
        }
    }
    
    init(index : Int) {
        switch index {
        case 0:
            self = .alarm
        case 1:
            self = .morningRoutine
        case 2:
            self = .arriveAtADA
        default:
            self = .alarm
        }
    }
}

final class HomeViewModel : ObservableObject {
    
    @Published var isTodayDoneStreak : Bool {
        didSet {
            UserDefaults.standard.set(isTodayDoneStreak, forKey: "isTodayDoneStreak")
        }
    }
    
    @Published var streakCount : Int {
        didSet {
            UserDefaults.standard.set(streakCount, forKey: "streakCount")
        }
    }
      
    @Published var completedQuest : Int {
        didSet {
            UserDefaults.standard.set(completedQuest, forKey: "completedQuest")
        }
    }
    
    @Published var maxCompletedQuest : Int {
        didSet {
            UserDefaults.standard.set(completedQuest, forKey: "maxCompletedQuest")
        }
    }
    
    @Published var menuState : homeViewSelectionState = .alarm {
        didSet {
            UserDefaults.standard.set(menuState.selectedIndex, forKey: "menuSelectedIndex")
        }
    }
   
    func updateState(state : homeViewSelectionState){
        withAnimation {
            self.menuState = state
        }
    }
    
    init() {
        self.isTodayDoneStreak = UserDefaults.standard.bool(forKey: "isTodayDoneStreak")
        self.streakCount = UserDefaults.standard.integer(forKey: "streakCount")
        self.completedQuest = UserDefaults.standard.integer(forKey: "completedQuest")
        self.maxCompletedQuest = UserDefaults.standard.integer(forKey: "maxCompletedQuest")
        self.menuState = homeViewSelectionState(index: UserDefaults.standard.integer(forKey: "menuSelectedIndex"))
    }
    
    static let gridColumns = [GridItem(.flexible(minimum: 0, maximum: 150)),GridItem(.flexible())]
}

private extension HomeViewModel {
   
}
