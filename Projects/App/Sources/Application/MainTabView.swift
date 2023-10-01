//
//  MainTabView.swift
//  DoForest
//
//  Created by 정종인 on 10/2/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import HomeFeature
import RoomFeature

struct MainTabView: View {
    let store: StoreOf<MainTab>
    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: { .path($0) })) {
            HomeView(store: self.store.scope(state: \.home, action: { .home($0) }))
        } destination: { store in
            switch store {
            case .customRoom:
                CaseLet(
                    /MainTab.Path.State.customRoom,
                     action: MainTab.Path.Action.customRoom,
                     then: CustomRoomView.init(store:)
                )
            }
        }
    }
}

#Preview {
    MainTabView(store: .init(initialState: MainTab.State(), reducer: {
        MainTab()
    }))
}
