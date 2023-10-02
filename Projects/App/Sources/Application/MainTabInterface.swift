//
//  MainTabInterface.swift
//  DoForest
//
//  Created by 정종인 on 10/2/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import HomeFeatureInterface
import RoomFeatureInterface

struct MainTab: Reducer {
    struct State: Equatable {
        var path = StackState<Path.State>()
        var home = Home.State()
    }
    enum Action: Equatable {
        case path(StackAction<Path.State, Path.Action>)
        case home(Home.Action)
    }
    struct Path: Reducer {
        enum State: Equatable {
            case customRoom(CustomRoom.State = .init())
            case createRoom(CreateRoom.State = .init())
        }
        enum Action: Equatable {
            case customRoom(CustomRoom.Action)
            case createRoom(CreateRoom.Action)
        }

        var body: some Reducer<State, Action> {
            Scope(state: /State.customRoom, action: /Action.customRoom) {
                CustomRoom()
            }
            Scope(state: /State.createRoom, action: /Action.createRoom) {
                CreateRoom()
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
                default:
                    return .none
                }
            case .home(.enterRoom(.navigateToCustomRoom)):
                state.path.append(.customRoom())
                return .none
            case .home(.createRoomButtonTapped):
                state.path.append(.createRoom())
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
