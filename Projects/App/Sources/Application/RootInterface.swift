//
//  RootInterface.swift
//  DoForest
//
//  Created by 정종인 on 10/2/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct Root: Reducer {
    enum State: Equatable {
        case mainTab(MainTab.State)

        init() {
            self = .mainTab(.init())
        }
    }

    enum Action: Equatable {
        case mainTab(MainTab.Action)
    }

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            default:
                return .none
            }
        }
        .ifCaseLet(/State.mainTab, action: /Action.mainTab) {
            MainTab()
        }
    }
}
