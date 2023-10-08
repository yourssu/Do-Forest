//
//  Haptic.swift
//  Util
//
//  Created by 정종인 on 10/7/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import Foundation
import UIKit

public typealias FeedbackType = UINotificationFeedbackGenerator.FeedbackType
public typealias FeedbackStyle = UIImpactFeedbackGenerator.FeedbackStyle

class HapticManager {
    static let instance = HapticManager()
    func notification(_ type: FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }

    func impact(_ style: FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

public func hapticNotification(_ type: FeedbackType) {
    HapticManager.instance.notification(type)
}

public func hapticImpact(_ style: FeedbackStyle) {
    HapticManager.instance.impact(style)
}
