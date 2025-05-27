//
//  watchToIOSConnectorManager.swift
//  watchOS Watch App
//
//  Created by William on 26/05/25.
//

import Foundation
import WatchConnectivity
import Observation

@Observable
final class WatchToIOSConnectorManager: NSObject, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
       
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        
    }
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func session(_ session: WCSession, didReceiveUserInfo userInfo: [String : Any] = [:]) {
        if let learnerSession = userInfo["learnerSessionType"] as? LearnerSessionType {
            updateWatchState(learnerSession: learnerSession)
        }
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if let learnerSession = message["learnerSessionType"] as? LearnerSessionType {
            updateWatchState(learnerSession: learnerSession)
        }
    }
    
    func updateWatchState(learnerSession : LearnerSessionType) {
        UserDefaults.standard.set("\(learnerSession.title)", forKey: "LearnerSessionType")
        UserDefaults.standard.set("\(QuestState.active.value)", forKey: "ADAState")
    }
}
