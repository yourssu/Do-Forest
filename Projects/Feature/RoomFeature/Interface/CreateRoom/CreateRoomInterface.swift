//
//  CreateRoomInterface.swift
//  RoomFeatureInterface
//
//  Created by 정종인 on 10/2/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import Foundation
import ComposableArchitecture
import RoomDomainInterface
import Util
import DesignSystem

public struct CreateRoom: Reducer {
    public init() {}
    public struct State: Equatable {
        public init() {}
        public typealias RoomType = RoomModel.RoomType

        public var phase: Phase = .pickRoomType

        public var previousButtonEnabled: Bool {
            phase != .pickRoomType && phase != .ending && phase != .loading
        }

        public var nextButtonEnabled: Bool {
            phase != .loading && isUserTypedRoomTitleValid && isUserTypedRoomSubtitleValid
        }

        public enum Phase: Equatable, CaseIterable {
            case pickRoomType
            case typeRoomTitle
            case typeRoomSubtitle
            case setTimeRange
            case loading
            case ending
        }

        @BindingState public var focusedField: Field?

        public enum Field: String, Hashable {
            case title, subtitle
        }

        // MARK: - phase 1
        public var userPickedRoom: RoomType = .custom

        // MARK: - phase 2
        @BindingState public var userTypedRoomTitle: String = ""
        public var isUserTypedRoomTitleValid: Bool {
            phase != .typeRoomTitle || (phase == .typeRoomTitle && !userTypedRoomTitle.isEmpty)
        }

        // MARK: - phase 3
        @BindingState public var userTypedRoomSubtitle: String = ""
        public var isUserTypedRoomSubtitleValid: Bool {
            phase != .typeRoomSubtitle || (phase == .typeRoomSubtitle && !userTypedRoomSubtitle.isEmpty)
        }

        // MARK: - phase 4
        @BindingState public var hasTimeRange: Bool = false
        @BindingState public var startTime: Date = Date()
        @BindingState public var endTime: Date = Date()

        public var startTimeDescription: String {
            dateFormatter(date: startTime)
        }

        public var endTimedescription: String {
            dateFormatter(date: endTime)
        }

        // MARK: - phase 5
        public var isLoading: Bool = false

        // MARK: - phase 6
        public var animationValue: AnimationValue = .init()
    }

    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case previousButtonTapped
        case nextButtonTapped

        // MARK: - phase 1
        case userPickedRoom(RoomModel.RoomType)

        // MARK: - phase 2
        case focusOnTitle

        // MARK: - phase 3
        case focusOnSubtitle

        // MARK: - phase 4

        // MARK: - phase 5

        // MARK: - phase 6
        case animating
        case dismiss
    }

    @Dependency(\.continuousClock) var clock
    @Dependency(\.dismiss) var dismiss

    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .previousButtonTapped:
                state.phase = state.phase.previous()
                return .none
            case .focusOnTitle:
                state.focusedField = .title
                return .none
            case .focusOnSubtitle:
                state.focusedField = .subtitle
                return .none
            case .nextButtonTapped:
                state.focusedField = nil
                if state.phase == .ending {
                    return .send(.dismiss)
                }
                state.phase = state.phase.next()
                if state.phase == .loading {
                    state.isLoading = true
                    return .run { send in
                        try await clock.sleep(for: .seconds(2))
                        await send(.nextButtonTapped, animation: .default)
                    }
                } else {
                    return .none
                }
            case .userPickedRoom(let roomType):
                state.userPickedRoom = roomType
                return .none
            case .animating:
                state.animationValue.trigger()
                return .none
            case .dismiss:
                return .run { _ in
                    await self.dismiss()
                }
            }
        }
    }
}

private extension CreateRoom.State {
    private func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "a hh시 mm분"
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.string(from: date)
    }
}
