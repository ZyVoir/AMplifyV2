//
//  WatchArriveAtADAViewModel.swift
//  watchOS Watch App
//
//  Created by William on 25/05/25.
//

import Foundation
import Observation

@Observable
class WatchArriveAtADAViewModel {
    
    var sessionSelection : LearnerSessionType = .morning {
        didSet {
            UserDefaults.standard.set(sessionSelection.title, forKey: "LearnerSessionType")
        }
    }
    
    var state : QuestState? = .ready {
        didSet {
            if let state = state?.value {
                UserDefaults.standard.set(state, forKey: "ADAState")
            }
        }
    }
    
    init(sessionSelection: LearnerSessionType? = .morning, state: QuestState? = .ready) {
        if let session = sessionSelection, let state = state {
            self.sessionSelection = session
            self.state = state
        }
    }
}
