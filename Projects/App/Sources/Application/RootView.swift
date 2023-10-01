//
//  RootView.swift
//  DoForest
//
//  Created by 정종인 on 10/1/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import HomeFeature

struct Root: Reducer {
    struct State: Equatable {
        var path = StackState<Path.State>()
        var home = Home.State()
    }
    enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        case home(Home.Action)
        case initialPath
    }

    struct Path: Reducer {
        enum State: Codable, Equatable, Hashable {
            case customRoom(CustomRoom.State = .init())
        }
        enum Action: Equatable {
            case customRoom(CustomRoom.Action)
        }

        var body: some Reducer<State, Action> {
            Scope(state: /State.customRoom, action: /Action.customRoom) {
                CustomRoom()
            }
        }
    }

    var body: some Reducer<State, Action> {
        Scope(state: \.home, action: /Action.home) {
            Home()
        }
        Reduce { state, action in
            switch action {
            case let .path(action):
                switch action {
//                case .element(id: _, action: .home(.enterRoom(.submitButtonTapped))):
//                    state.path.append(.customRoom())
//                    return .none
                default:
                    return .none
                }
            case .initialPath:
                return .none
            case .home(.enterRoom(.submitButtonTapped)):
                state.path.append(.customRoom())
                print("submit button Tapped!")
                return .none
            default:
                return .none
            }
        }
        .forEach(\.path, action: /Action.path) {
            Path()
        }
    }
}

struct RootView: View {
    let store: StoreOf<Root>

    var body: some View {
        NavigationStackStore(self.store.scope(state: \.path, action: Root.Action.path)) {
            HomeView(store: self.store.scope(state: \.home, action: Root.Action.home))
        } destination: { store in
            switch store {
            case .customRoom:
                CaseLet(
                    /Root.Path.State.customRoom,
                     action: Root.Path.Action.customRoom,
                     then: CustomRoomView.init(store:)
                )
            }
        }
    }
}

#Preview {
    RootView(store: .init(initialState: Root.State(), reducer: {
        Root()
    }))
}
