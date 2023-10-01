//
//  HomeView.swift
//  HomeFeature
//
//  Created by 정종인 on 9/30/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import RoomDomainInterface
import Util
import YDS_SwiftUI
import HomeFeatureInterface

public struct HomeView: View {
    public init(store: StoreOf<Home>) {
        self.store = store
    }
    public let store: StoreOf<Home>
    private func roomListView(rooms: [RoomModel]) -> some View {
        LazyVStack(alignment: .leading, spacing: 20) {
            ForEach(rooms, id: \.id) { room in
                HStack(spacing: 16) {
                    Text(room.icon)
                        .font(.largeTitle)
                        .frame(minWidth: 64, minHeight: 64)
                        .background {
                            Color.white
                                .clipShape(Circle())
                        }
                    VStack(alignment: .leading, spacing: 8) {
                        Text(room.title)
                            .font(YDSFont.title3)
                        Text(room.subTitle)
                            .font(YDSFont.body2)
                    }
                    Spacer()
                }
                .foregroundStyle(Color.white)
                .padding(26)
                .frame(maxWidth: .infinity, minHeight: 107)
                .background {
                    RoundedRectangle(cornerRadius: 30, style: .continuous)
                        .fill(Color(hex: room.backgroundHexColor))
                }
            }
        }
    }
    private func popupEntry(viewStore: ViewStoreOf<Home>) -> some View {
        VStack(spacing: 16) {
            Text("🌱")
                .font(.system(size: 80))
            Group {
                Button(action: {
                    viewStore.send(.enterCodeButtonTapped)
                }, label: {
                    Text("코드 입력")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                        .foregroundStyle(Color(hex: 0x2C5F2D))
                })
                .tint(Color(hex: 0x93CD99, alpha: 100))
                Button(action: {}, label: {
                    Text("방 개설하기")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                })
                .foregroundStyle(Color(hex: 0xFFFFFF))
                .tint(Color(hex: 0x2C5F2D, alpha: 100))
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.capsule)
        }
    }
    @MainActor
    private func popupEnterCode(store: StoreOf<EnterRoom>) -> some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                TextField("코드를 입력해주세요.", text: viewStore.$text)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20)
                    .background {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Color(hex: 0xE4E2E2))
                            .cornerRadius(60)
                    }
                Button(action: {
                    viewStore.send(.submitButtonTapped)
                }, label: {
                    Text("방 입장하기")
                        .frame(maxWidth: .infinity, maxHeight: 40)
                })
                .foregroundStyle(Color(hex: 0xFFFFFF))
                .tint(Color(hex: 0x2C5F2D, alpha: 100))
                .buttonStyle(.bordered)
                .buttonBorderShape(.capsule)
            }
        }
    }
    @MainActor
    private func popupWindow(viewStore: ViewStoreOf<Home>) -> some View {
        ZStack {
            Color.black.opacity(0.5)
                .onTapGesture {
                    viewStore.send(.closeButtonTapped)
                }
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack(spacing: 16) {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewStore.send(.closeButtonTapped)
                        }, label: {
                            Image(systemName: "xmark")
                                .frame(maxWidth: 16, maxHeight: 16)
                                .padding(8)
                                .contentShape(Circle())
                                .foregroundStyle(Color(hex: 0x3C3C43, alpha: 0.6))
                        })
                    }
                    Text("방 참여하기")
                        .font(YDSFont.title1)
                    Text("챌린지 방에 참가하여\n나만의 잔디를 심어보세요!")
                        .multilineTextAlignment(.center)
                        .font(YDSFont.body1)
                    if viewStore.isEntering {
                        popupEnterCode(store: self.store.scope(state: \.enterRoom, action: Home.Action.enterRoom))
                            .transition(.opacity)
                    } else {
                        popupEntry(viewStore: viewStore)
                            .transition(.opacity)
                    }
                }
                .padding(18)
                .frame(maxWidth: .infinity)
                .background {
                    RoundedRectangle(cornerRadius: 35.0, style: .continuous)
                        .fill(Color.white)
                }
                .padding(.horizontal, 40)
                Spacer()
            }
            .ignoresSafeArea(edges: .top)
        }
    }
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    roomListView(rooms: viewStore.rooms)
                }
                .padding()
                Button {
                    viewStore.send(.floatingButtonTapped)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 61, maxHeight: 61)
                        .foregroundStyle(Color.white, Color(hex: 0x72C381))
                }
                .padding()
                .symbolEffect(.bounce, value: viewStore.floatingButtonAnimation)
                if viewStore.isPopupPresenting {
                    popupWindow(viewStore: viewStore)
                        .zIndex(1.0)
                        .transition(.opacity)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("함께해요")
                        .font(YDSFont.display2)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewStore.send(.settingButtonTapped)
                    } label: {
                        Image(systemName: "gearshape")
                    }
                    .disabled(viewStore.isPopupPresenting)
                    .symbolEffect(.bounce, value: viewStore.settingIconAnimation)
                }
            }
            .animation(.easeInOut, value: viewStore.isPopupPresenting)
            .animation(.easeInOut, value: viewStore.isEntering)
        }
    }
}

public struct EnterRoom: Reducer {
    public init() {}
    public struct State: Equatable {
        public init() {}
        @BindingState var text = ""
    }
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case submitButtonTapped
    }

    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .submitButtonTapped:
                print("text: \(state.text)")
                return .none
            }
        }
    }
}

public struct Home: Reducer {
    public init() {}
    public struct State: Equatable {
        public init() {}
        var rooms: [RoomModel] = RoomModel.mockData
        var settingIconAnimation = AnimationValue()
        var floatingButtonAnimation = AnimationValue()
        var isPopupPresenting: Bool = true
        var isEntering: Bool = true
        var enterRoom = EnterRoom.State()
    }
    public enum Action: Equatable {
        case buttonTapped
        case settingButtonTapped
        case floatingButtonTapped
        case closeButtonTapped
        case enterCodeButtonTapped
        case enterRoom(EnterRoom.Action)
    }

    public var body: some Reducer<State, Action> {
        Scope(state: \.enterRoom, action: /Action.enterRoom) {
            EnterRoom()
        }
        Reduce { state, action in
            switch action {
            case .buttonTapped:
                return .none
            case .settingButtonTapped:
                state.settingIconAnimation.trigger()
                return .none
            case .floatingButtonTapped:
                state.floatingButtonAnimation.trigger()
                state.isPopupPresenting = true
                return .none
            case .closeButtonTapped:
                state.isPopupPresenting = false
                state.isEntering = false
                return .none
            case .enterCodeButtonTapped:
                state.isEntering = true
                return .none
            case .enterRoom(_):
                return .none
            }
        }
    }
}

public struct AnimationValue: Equatable {
    public init() {}
    private enum Phase {
        case phase1
        case phase2
    }
    private var phase: Phase = .phase1
    public mutating func trigger() {
        switch phase {
        case .phase1:
            self.phase = .phase2
        case .phase2:
            self.phase = .phase1
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
