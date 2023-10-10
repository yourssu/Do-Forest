//
//  HomePreview.swift
//  HomeFeatureDemo
//
//  Created by 정종인 on 10/11/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import HomeFeature
import HomeFeatureInterface
import ComposableArchitecture
import HomeFeatureTesting

#Preview {
    registerRoomTestDependency()
    return NavigationStack {
        HomeView(store: Store(initialState: Home.State(), reducer: {
            Home()
        }))
    }
}
