//
//  DoForestApp.swift
//  DoForest
//
//  Created by 정종인 on 9/30/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

@main
struct DoForestApp: App {
    var body: some Scene {
        WindowGroup {
            RootView(store: .init(initialState: Root.State()) {
                Root()
            })
        }
    }
}
