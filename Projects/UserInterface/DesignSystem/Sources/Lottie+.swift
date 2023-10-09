//
//  Lottie+.swift
//  DesignSystem
//
//  Created by 정종인 on 10/9/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import Lottie
import UIKit
import SwiftUI

public struct LottieViewEntry: View {
    public let lottie: LottieAnimationType
    public let loopMode: LottieLoopMode
    public let speed: CGFloat
    public enum LottieAnimationType: String {
        case congratulations
        internal var filename: String {
            switch self {
            case .congratulations:
                "Congratulations"
            }
        }
    }
    public init(_ lottie: LottieAnimationType, loopMode: LottieLoopMode = .loop, speed: CGFloat = 1.0) {
        self.lottie = lottie
        self.loopMode = loopMode
        self.speed = speed
    }
    public var body: some View {
        LottieView(animation: .named(lottie.filename, bundle: .module))
            .configure({ lottieView in
                lottieView.animationSpeed = speed
                lottieView.loopMode = loopMode
            })
            .playing()
    }
}

#Preview {
    LottieViewEntry(.congratulations, loopMode: .loop, speed: 1.0)
}
