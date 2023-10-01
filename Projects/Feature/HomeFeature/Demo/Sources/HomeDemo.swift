//
//  HomeDemo.swift
//  HomeFeatureDemo
//
//  Created by 정종인 on 9/30/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import HomeFeature
import HomeFeatureInterface
import ComposableArchitecture

@main
struct HomeDemo: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(store: .init(initialState: Home.State(), reducer: {
                    Home()
                }))
            }
        }
    }
}

#Preview {
    NavigationStack {
        HomeView(store: Store(initialState: Home.State(), reducer: {
            Home()
        }))
    }
}
