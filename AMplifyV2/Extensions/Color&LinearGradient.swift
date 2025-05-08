//
//  Color&LinearGradient.swift
//  AMplifyV2
//
//  Created by William on 07/05/25.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let r, g, b: Double
        if hexSanitized.count == 6 {
            r = Double((rgb & 0xFF0000) >> 16) / 255
            g = Double((rgb & 0x00FF00) >> 8) / 255
            b = Double(rgb & 0x0000FF) / 255

            self.init(.sRGB, red: r, green: g, blue: b, opacity: 1)
        } else {
            self.init(.sRGB, red: 0, green: 0, blue: 0, opacity: 1)
        }
    }

    
    static let Primary = Color(hex: "#0CACC5")
    
    static let SplashBlue = Color(hex: "#01ABC4")
    static let SplashDarkBlue = Color(hex: "#01353D")
    
    static let accentDarkOrange = Color(hex: "#FF6F20")
    static let accentOrange = Color(hex: "#FFAC34")
    
    static let accentGrey = Color(hex: "#BABABA")
    
    static let GreyBG = Color(hex: "#F6F6F6")
    
}

extension LinearGradient {
    init(colors: [Color], startPoint: UnitPoint = .top, endPoint: UnitPoint = .bottom) {
        self.init(gradient: Gradient(colors: colors), startPoint: startPoint, endPoint: endPoint)
    }
    
    static let SplashBG: LinearGradient = .init(colors: [.SplashBlue, .SplashDarkBlue], startPoint: .topLeading, endPoint: .bottomTrailing)
    static let StreakColor : LinearGradient = .init(colors: [.accentDarkOrange, .accentOrange], startPoint: .topLeading, endPoint: .bottomTrailing)
    
    static let greyBG : LinearGradient = .init(colors: [.accentGrey], startPoint: .topLeading, endPoint: .bottomTrailing)
}
