//
//  Item.swift
//  AMplifyV2
//
//  Created by William on 05/05/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
