//
//  ArriveAtADAAttributes.swift
//  AMplifyV2
//
//  Created by William on 13/05/25.
//

import ActivityKit
import Foundation

struct ArriveAtADAAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable, Equatable {
        // Dynamic stateful properties about your activity go here!
        var distance : Double
    }

    // Fixed non-changing properties about your activity go here!
    var endTime: Date
}
