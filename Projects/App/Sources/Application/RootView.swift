//
//  RootView.swift
//  DoForest
//
//  Created by 정종인 on 10/1/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct RootView: View {
    let store: StoreOf<Root>

    var body: some View {
        SwitchStore(self.store) { _ in
            CaseLet(/Root.State.mainTab, action: Root.Action.mainTab) {
                MainTabView(store: $0)
            }
        }
    }
}

#Preview {
    RootView(store: .init(initialState: Root.State(), reducer: {
        Root()
    }))
}
