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

public struct HomeView: View {
    public init(store: StoreOf<Home>) {
        self.store = store
    }
    public let store: StoreOf<Home>
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(alignment: .leading, spacing: 20) {
                ForEach(viewStore.rooms, id: \.id) { room in
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
                    .padding(.horizontal)
                }
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
        public init() {}
        var rooms: [RoomModel] = RoomModel.mockData
    }
    public enum Action: Equatable {
        case buttonTapped
    }

    public func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .buttonTapped:
            return .none
        }
    }
}
