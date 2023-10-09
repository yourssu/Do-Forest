//
//  CreateRoomView.swift
//  RoomFeatureInterface
//
//  Created by 정종인 on 10/2/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import ComposableArchitecture
import RoomFeatureInterface
import YDS_SwiftUI

public struct CreateRoomView: View {
    public init(store: StoreOf<CreateRoom>) {
        self.store = store
    }
    public let store: StoreOf<CreateRoom>
    @FocusState var focusedField: CreateRoom.State.Field?
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack {
                Spacer()
                switch viewStore.phase {
                case .pickRoomType:
                    pickRoomTypeView(viewStore: viewStore)
                case .typeRoomTitle:
                    typeRoomTitleView(viewStore: viewStore)
                case .typeRoomSubtitle:
                    typeRoomSubtitleView(viewStore: viewStore)
                case .setTimeRange:
                    setTimeRangeView(viewStore: viewStore)
                case .loading:
                    loadingView(viewStore: viewStore)
                case .ending:
                    endingView(viewStore: viewStore)
                }
                Spacer()
                HStack(spacing: 16) {
                    if viewStore.previousButtonEnabled {
                        Button(action: {
                            viewStore.send(.previousButtonTapped, animation: .default)
                        }, label: {
                            Text("이전")
                                .frame(maxWidth: 96, minHeight: 48)
                        })
                        .background(Color.buttonPoint)
                        .clipShape(.buttonBorder)
                    }
                    if viewStore.nextButtonEnabled {
                        Button(action: {
                            viewStore.send(.nextButtonTapped, animation: .default)
                        }, label: {
                            Text(viewStore.phase == .ending ? "완료" : viewStore.phase == .setTimeRange ? "방 개설하기" : "다음")
                                .frame(maxWidth: .infinity, minHeight: 48)
                        })
                        .background(Color.buttonPoint)
                        .clipShape(.buttonBorder)
                    }
                }
                .font(YDSFont.title2)
                .foregroundStyle(Color.white)
                .padding()
                .animation(.default, value: viewStore.nextButtonEnabled)
                .animation(.default, value: viewStore.previousButtonEnabled)
                .bind(viewStore.$focusedField, to: self.$focusedField)
            }
        }
        .addBackButton()
    }

    @ViewBuilder
    private func pickRoomTypeView(viewStore: ViewStoreOf<CreateRoom>) -> some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("방 종류를 선택해주세요")
                .font(YDSFont.title1)
            ForEach(CreateRoom.State.RoomType.allCases, id: \.self) { room in
                HStack(alignment: .lastTextBaseline) {
                    Text(room.title)
                        .font(YDSFont.subtitle1)
                    Spacer()
                    Text(room.subTitle)
                        .font(YDSFont.body2)
                }
                .padding(24)
                .frame(maxWidth: .infinity, maxHeight: 70)
                .background(.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 1)
                        .stroke(
                            viewStore.userPickedRoom == room
                            ? Color.bgElevated
                            : Color.textDisabled,
                            lineWidth: viewStore.userPickedRoom == room ? 6 : 2
                        )
                )
                .onTapGesture {
                    viewStore.send(.userPickedRoom(room), animation: .default)
                }
            }
        }
        .padding(16)
    }

    @ViewBuilder @MainActor
    private func typeRoomTitleView(viewStore: ViewStoreOf<CreateRoom>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("방 이름을 입력해주세요")
                .font(YDSFont.title1)
            Text("목표를 잘 보여줄 수 있는 이름도 좋아요!")
                .font(YDSFont.body2)
                .padding(.bottom, 24)
            TextField("방 이름", text: viewStore.$userTypedRoomTitle)
                .font(YDSFont.body1)
                .focused($focusedField, equals: .title)
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 1)
                .background(Color.buttonPoint)
        }
        .padding(16)
        .onAppear {
            viewStore.send(.focusOnTitle)
        }
    }

    @ViewBuilder @MainActor
    private func typeRoomSubtitleView(viewStore: ViewStoreOf<CreateRoom>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("목표를 정해주세요")
                .font(YDSFont.title1)
                .padding(.bottom, 40)
            TextField("방 이름", text: viewStore.$userTypedRoomSubtitle)
                .font(YDSFont.body1)
                .focused($focusedField, equals: .subtitle)
            Rectangle()
                .foregroundColor(.clear)
                .frame(height: 1)
                .background(Color.buttonPoint)
        }
        .padding(16)
        .onAppear {
            viewStore.send(.focusOnSubtitle)
        }
    }

    @ViewBuilder @MainActor
    private func setTimeRangeView(viewStore: ViewStoreOf<CreateRoom>) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("시간을 설정하실건가요?")
                    .font(YDSFont.title1)
                Spacer()
                Toggle("", isOn: viewStore.$hasTimeRange)
                    .labelsHidden()
            }
            Text("방 개설 후에는 다시 수정할 수 없으니 신중하게 결정해주세요.")
                .font(YDSFont.body2)
                .padding(.bottom, 24)
            if viewStore.hasTimeRange {
                DatePicker(selection: viewStore.$startTime, displayedComponents: .hourAndMinute) {
                    Text("시작 시간")
                }
                .padding(.horizontal)
                DatePicker(selection: viewStore.$endTime, displayedComponents: .hourAndMinute) {
                    Text("종료 시간")
                }
                .padding(.horizontal)
            }
        }
        .padding(16)
        .animation(.default, value: viewStore.hasTimeRange)
    }

    @ViewBuilder
    private func loadingView(viewStore: ViewStoreOf<CreateRoom>) -> some View {
        VStack {
            Text("방을 개설하고 있어요")
                .font(YDSFont.title1)
            ProgressView()
        }
    }

    @ViewBuilder
    private func endingView(viewStore: ViewStoreOf<CreateRoom>) -> some View {
        VStack(spacing: 8) {
            Text("방 개설 완료!")
                .font(YDSFont.title1)
            Text("Do Forest와 함께 알찬 시간 보내요~!")
                .font(YDSFont.body1)
                .padding(.bottom, 16)
            Image(systemName: "checkmark.circle")
                .resizable()
                .frame(maxWidth: 60, maxHeight: 60)
                .foregroundStyle(Color.buttonPoint)
                .symbolEffect(.bounce, options: .repeating, value: viewStore.animationValue)
        }
        .onAppear {
            viewStore.send(.animating, animation: .snappy(duration: 2.5, extraBounce: 5.0))
        }
    }
}

#Preview {
    NavigationStack {
        CreateRoomView(store: .init(initialState: CreateRoom.State(), reducer: {
            CreateRoom()
        }))
    }
}
