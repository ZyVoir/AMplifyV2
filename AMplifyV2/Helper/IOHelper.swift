//
//  IOHelper.swift
//  AMplifyV2
//
//  Created by William on 05/05/25.
//

import Foundation

class IOHelper {
    static let shared = IOHelper()
    
    private init() {}
    
    func parseStringToListOfIntComponent(_ string: String) -> [Int] {
        return string.split(separator: ":").map { Int(String($0))! }
    }
    
    func parseStringToDate(_ dateString: String) -> Date {
        let calendar = Calendar.current
        
        let intComponent = parseStringToListOfIntComponent(dateString)
        
        var dateComponents = calendar.dateComponents([.year,.month,.day], from: Date())
        
        dateComponents.hour = intComponent[0]
        dateComponents.minute = intComponent[1]
        dateComponents.second = intComponent[2]
        
        return calendar.date(from: dateComponents) ?? Date()
    }
    
    func formattedDistance(distance : Double) -> String {
        if (distance >= 1){
            return String(format: "%.0f", distance)
        }
        else {
           return String(format: "%.2f", distance)
        }
    }
    
    func timeDifferencePhrase(from startDate: Date, to endDate: Date) -> String {
        let totalSeconds = Int(abs(endDate.timeIntervalSince(startDate)))
        
        let hours = totalSeconds / 3600
        let minutes = (totalSeconds % 3600) / 60
        let seconds = totalSeconds % 60

        var parts: [String] = []

        if hours > 0 {
            parts.append("\(hours) hour" + (hours == 1 ? "" : "s"))
        }
        if minutes > 0 {
            parts.append("\(minutes) minute" + (minutes == 1 ? "" : "s"))
        }
        if seconds > 0 || parts.isEmpty {
            parts.append("\(seconds) second" + (seconds == 1 ? "" : "s"))
        }

        // Formatting: "X hours, Y minutes and Z seconds"
        switch parts.count {
        case 1:
            return parts[0]
        case 2:
            return parts.joined(separator: " and ")
        default:
            let last = parts.removeLast()
            return parts.joined(separator: ", ") + " and " + last
        }
    }

}

