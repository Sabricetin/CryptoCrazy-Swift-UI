//
//  Color-Extension.swift
//  CryptoCrazy-Swift-UI
//
//  Created by Sabri Çetin on 4.09.2024.
//

import Foundation

import SwiftUI

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b, a: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (r, g, b, a) = ((int >> 8 * 4) & 0xF, (int >> 4) & 0xF, int & 0xF, 15)
            self.init(
                red: Double(r) / 15.0,
                green: Double(g) / 15.0,
                blue: Double(b) / 15.0,
                opacity: Double(a) / 15.0
            )
        case 6: // RGB (24-bit)
            (r, g, b, a) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF, 255)
            self.init(
                red: Double(r) / 255.0,
                green: Double(g) / 255.0,
                blue: Double(b) / 255.0
            )
        case 8: // ARGB (32-bit)
            (r, g, b, a) = ((int >> 16) & 0xFF, (int >> 8) & 0xFF, int & 0xFF, (int >> 24) & 0xFF)
            self.init(
                red: Double(r) / 255.0,
                green: Double(g) / 255.0,
                blue: Double(b) / 255.0,
                opacity: Double(a) / 255.0
            )
        default:
            self.init(.clear)
        }
    }
}
