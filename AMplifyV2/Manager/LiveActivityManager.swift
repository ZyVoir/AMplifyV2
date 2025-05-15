//
//  LiveActivityManager.swift
//  AMplifyV2
//
//  Created by William on 13/05/25.
//

import ActivityKit
import Foundation

final class LiveActivityManager {
    static let shared = LiveActivityManager()
    
    private init () {}
    
    private var activity: Activity<ArriveAtADAAttributes>?
    
    func startActivity(distance : Double, endTime : Date) {
        let attributes = ArriveAtADAAttributes(endTime: endTime)
        let contentState = ArriveAtADAAttributes.ContentState(distance: distance)
        
        do {
            activity = try Activity<ArriveAtADAAttributes>.request(
                attributes: attributes,
                content: .init(state: contentState, staleDate: nil),
                pushType: .none // only needed for push-based updates
            )
            print("Live Activity started.")
        } catch {
            print("Failed to start Live Activity: \(error)")
        }
    }
    
    func updateActivity(distance: Double) {
        guard let activity = activity else {
            print("⚠️ No active Live Activity to update.")
            return
        }
        
        let updatedState = ArriveAtADAAttributes.ContentState(distance: distance)
        
        Task {
            await activity.update(.init(state: updatedState, staleDate: .distantFuture))
            print("🔄 Live Activity updated.")
        }
    }
    
    func endActivity(finalDistance: Double) {
        guard let activity = activity else {
            print("⚠️ No active Live Activity to end.")
            return
        }
        
        let finalState = ArriveAtADAAttributes.ContentState(distance: finalDistance)
        
        Task {
            await activity.end(.init(state: finalState, staleDate: .distantFuture), dismissalPolicy: .immediate)
            print("🛑 Live Activity ended.")
        }
    }
}
