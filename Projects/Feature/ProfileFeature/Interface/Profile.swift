//
//  Profile.swift
//  ProfileFeatureInterface
//
//  Created by 정종인 on 10/9/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import ComposableArchitecture

public struct Profile: Reducer {
    public init() {}

    public struct State: Equatable {
        public init() {}

    }
    public enum Action: Equatable {
        case loadProfile
    }
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadProfile:
                return .none
            }
        }
    }
}
