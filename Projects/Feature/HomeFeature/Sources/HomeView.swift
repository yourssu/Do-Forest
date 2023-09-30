//
//  HomeView.swift
//  HomeFeature
//
//  Created by 정종인 on 9/30/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

public struct HomeView: View {
    public init(store: StoreOf<Home>) {
        self.store = store
    }
    public let store: StoreOf<Home>
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Text("count : \(viewStore.count)")
                Button(action: {
                    viewStore.send(.buttonTapped)
                }, label: {
                    Text("Button")
                })
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView(store: Store(initialState: Home.State(), reducer: {
                Home()
            }))
        }
    }
}

public struct Home: Reducer {
    public init() {}
    public struct State: Equatable {
        public init(count: Int = 0) {
            self.count = count
        }
        var count = 0
    }
    public enum Action: Equatable {
        case buttonTapped
    }

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .buttonTapped:
            state.count += 1
            return .none
        }
    }
}
