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
}

