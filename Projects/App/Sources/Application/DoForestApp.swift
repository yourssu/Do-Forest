//
//  DoForestApp.swift
//  DoForest
//
//  Created by 정종인 on 9/30/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import HomeFeature

@main
struct DoForestApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(store: .init(initialState: Home.State(), reducer: {
                    Home()
                }))
            }
            .zIndex(1.0)
        }
    }
}
