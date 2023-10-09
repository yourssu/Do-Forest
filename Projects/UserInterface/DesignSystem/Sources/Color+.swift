//
//  Color+.swift
//  DesignSystem
//
//  Created by 정종인 on 10/9/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI

public extension Color {
    static let whiteGreen = Color(red: 0.58, green: 0.8, blue: 0.6)
    static let lightGreen = Color(red: 0.45, green: 0.76, blue: 0.51)
    static let darkGreen = Color(red: 0.17, green: 0.37, blue: 0.18)
    static let buttonPoint = Color(red: 0.16, green: 0.58, blue: 0.24)
    static let bgElevated = Color(red: 0.58, green: 0.69, blue: 0.62)
    static let lightGray = Color(red: 0.9, green: 0.89, blue: 0.89)
    static let lightLabelSecondary = Color(red: 0.24, green: 0.24, blue: 0.26, opacity: 0.6)
    static let textDisabled = Color(red: 0.71, green: 0.73, blue: 0.74)
}

public extension Color {
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
}
