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
import DesignSystem

public struct HomeView: View {
    public init(store: StoreOf<Home>) {
        self.store = store
        store.send(.loadRooms)
    }
    public let store: StoreOf<Home>

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    roomListView(viewStore: viewStore)
                }
                .padding()
                Button {
                    viewStore.send(.floatingButtonTapped)
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 61, maxHeight: 61)
                        .foregroundStyle(Color.white, Color.lightGreen)
                }
                .padding()
                .symbolEffect(.bounce, value: viewStore.floatingButtonAnimation)
                if viewStore.isPopupPresenting {
                    popupWindow(viewStore: viewStore)
                        .zIndex(1.0)
                        .transition(.opacity)
                }
            }
            .refreshable {
                await viewStore.send(.loadRooms).finish()
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

    @ViewBuilder
    private func roomListView(viewStore: ViewStoreOf<Home>) -> some View {
        if let rooms = viewStore.rooms {
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
                    .onTapGesture {
                        viewStore.send(.enterRoom(room))
                    }
                }
            }
        } else {
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
    }
    @ViewBuilder
    private func popupEntry(viewStore: ViewStoreOf<Home>) -> some View {
        VStack(spacing: 16) {
            Text("🌱")
                .font(.system(size: 80))
            Group {
                Button(action: {
                    viewStore.send(.enterCodeButtonTapped)
                }, label: {
                    Text("코드 입력")
                        .frame(maxWidth: .infinity, minHeight: 48)
                        .foregroundStyle(Color.darkGreen)
                })
                .background(Color.whiteGreen)
                Button(action: {
                    viewStore.send(.createRoomButtonTapped)
                }, label: {
                    Text("방 개설하기")
                        .frame(maxWidth: .infinity, minHeight: 48)
                })
                .foregroundStyle(Color.white)
                .background(Color.darkGreen)
            }
            .clipShape(.capsule)
        }
    }
    @ViewBuilder @MainActor
    private func popupEnterCode(store: StoreOf<EnterRoomPopup>) -> some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                TextField("코드를 입력해주세요.", text: viewStore.$text)
                    .frame(maxWidth: .infinity, minHeight: 48)
                    .padding(.horizontal, 20)
                    .background(Color.lightGray)
                    .clipShape(.capsule)
                if viewStore.isActivityIndicatorVisible {
                    ProgressView()
                        .transition(.opacity)
                } else {
                    Button(action: {
                        viewStore.send(.submitButtonTapped)
                    }, label: {
                        Text("방 입장하기")
                            .frame(maxWidth: .infinity, minHeight: 48)
                    })
                    .foregroundStyle(Color.white)
                    .background(Color.darkGreen)
                    .clipShape(.capsule)
                }
            }
        }
    }
    @ViewBuilder @MainActor
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
                                .foregroundStyle(Color.lightLabelSecondary)
                        })
                    }
                    Text("방 참여하기")
                        .font(YDSFont.title1)
                    Text("챌린지 방에 참가하여\n나만의 잔디를 심어보세요!")
                        .multilineTextAlignment(.center)
                        .font(YDSFont.body1)
                    if viewStore.isEntering {
                        IfLetStore(self.store.scope(state: \.enterRoomPopup, action: { .enterRoomPopup($0) })) {
                            popupEnterCode(store: $0)
                        }
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
}

#Preview {
    NavigationStack {
        HomeView(store: Store(initialState: Home.State(), reducer: {
            Home()
        }))
    }
}
