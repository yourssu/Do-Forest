//
//  AnimationValue.swift
//  Util
//
//  Created by 정종인 on 10/3/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import Foundation

public struct AnimationValue: Equatable, Hashable, Codable {
    public init() {}
    public init(from decoder: Decoder) throws {}
    public func encode(to encoder: Encoder) throws {}
    public enum Phase: String {
        case phase1
        case phase2
    }
    public var phase: Phase = .phase1
    public mutating func trigger() {
        switch phase {
        case .phase1:
            self.phase = .phase2
        case .phase2:
            self.phase = .phase1
        }
    }
}
