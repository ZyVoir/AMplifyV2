//
//  HomeViewModel.swift
//  AMplifyV2
//
//  Created by William on 07/05/25.
//

import Foundation
import Observation
import SwiftUI

enum homeViewSelectionState : Int {
    case alarm = 0
    case morningRoutine = 1
    case arriveAtADA = 2
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
    
    @Published var menuState : homeViewSelectionState = .arriveAtADA
    
    @Published var menuSelectedIndex : Int {
        didSet {
            UserDefaults.standard.set(menuSelectedIndex, forKey: "menuSelectedIndex")
            withAnimation {
                menuState = homeViewSelectionState(rawValue: menuSelectedIndex)!
            }
        }
    }
    
    init() {
        self.isTodayDoneStreak = UserDefaults.standard.bool(forKey: "isTodayDoneStreak")
        self.streakCount = UserDefaults.standard.integer(forKey: "streakCount")
        self.completedQuest = UserDefaults.standard.integer(forKey: "completedQuest")
        self.maxCompletedQuest = UserDefaults.standard.integer(forKey: "maxCompletedQuest")
        self.menuSelectedIndex = UserDefaults.standard.integer(forKey: "menuSelectedIndex")
    }
    
    static let gridColumns = [GridItem(.flexible(minimum: 0, maximum: 150)),GridItem(.flexible())]
}
