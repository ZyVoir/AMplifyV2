//
//  iOSToWatchConnectorManager.swift
//  AMplifyV2
//
//  Created by William on 26/05/25.
//

import Foundation
import WatchConnectivity
import Observation

@Observable
class iOSToWatchConnectorManager: NSObject, WCSessionDelegate {
    
    var session: WCSession
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        self.session.delegate = self
        self.session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func activateStateInWatch(ForSession learnerSessionType : LearnerSessionType) {
        let userInfo : [String : Any] = ["learnerSessionType" : learnerSessionType]
        
        if session.isReachable {
            session.sendMessage(userInfo, replyHandler: nil)
        }
        else {
            session.transferUserInfo(userInfo)
        }
    }
}
