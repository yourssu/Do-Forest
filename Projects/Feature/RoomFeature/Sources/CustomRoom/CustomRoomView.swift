import SwiftUI
import ComposableArchitecture
import YDS_SwiftUI
import RoomFeatureInterface
import RoomDomainInterface
import DesignSystem

public struct CustomRoomView: View {
    public init(store: StoreOf<CustomRoom>) {
        self.store = store
    }
    public let store: StoreOf<CustomRoom>
    typealias Status = ParticipantModel.Status
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(spacing: 48) {
                    if viewStore.participants.isEmpty {
                        ProgressView()
                    } else {
                        participantsGroupView(viewStore: viewStore, status: .success)
                        participantsGroupView(viewStore: viewStore, status: .pending)
                        participantsGroupView(viewStore: viewStore, status: .failure)
                    }
                }
                .padding()
            }
            .toolbarBackground(Color(hex: viewStore.roomModel.backgroundHexColor), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .addBackButton()
            .navigationTitle(viewStore.roomModel.title)
            .navigationBarTitleDisplayMode(.large)
            .onAppear {
                viewStore.send(.loadParticipants)
            }
            .refreshable {
                await viewStore.send(.loadParticipants).finish()
            }
        }
    }
    @ViewBuilder
    private func participantsGroupView(viewStore: ViewStoreOf<CustomRoom>, status: Status) -> some View {
        var titleText: String {
            switch status {
            case .success:
                "잔디를 심은 사람 🌿"
            case .pending:
                "아직 잔디를 심지 않은 사람 🍂"
            case .failure:
                "오늘 잔디를 심지 못한 사람 😱"
            case .excluded:
                "제외된 사람"
            }
        }
        var participants: [ParticipantModel] {
            viewStore.participants.filter { $0.status == status }
        }
        var isExpand: Bool {
            switch status {
            case .success:
                viewStore.isExpandSuccess
            case .pending:
                viewStore.isExpandPending
            case .failure:
                viewStore.isExpandFailure
            default:
                true
            }
        }
        var pointColor: Color {
            Color(hex: viewStore.roomModel.backgroundHexColor)
        }
        LazyVStack(spacing: 16, pinnedViews: [.sectionHeaders]) {
            Section {
                if isExpand {
                    ForEach(participants, id: \.id) { participant in
                        switch status {
                        case .success:
                            participantSuccessView(participant, fillColor: pointColor)
                        case .pending:
                            participantPendingView(participant, strokeColor: pointColor)
                        case .failure:
                            participantFailureView(participant)
                        default:
                            EmptyView()
                        }
                    }
                }
            } header: {
                HStack {
                    Text(titleText)
                        .font(YDSFont.title2)
                    Spacer()
                    Button(action: {
                        viewStore.send(.toggleExpand(status), animation: .default)
                    }, label: {
                        Image(systemName: "triangle.fill")
                            .imageScale(isExpand ? .large : .medium)
                            .rotationEffect(isExpand ? .degrees(180) : .degrees(90))
                            .animation(.bouncy, value: isExpand)
                            .foregroundStyle(pointColor)
                    })
                }
                .padding(.vertical)
                .background(Color.white)
            }
        }
    }
    @ViewBuilder
    private func participantSuccessView(_ participant: ParticipantModel, fillColor: Color) -> some View {
        HStack {
            Text("\(participant.nickName) 성공 😎")
            Spacer()
            Text("연속 \(participant.strick)")
        }
        .font(YDSFont.body1)
        .foregroundStyle(Color.white)
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: 70, alignment: .leading)
        .background(fillColor)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .fill(.clear)
        )
    }
    @ViewBuilder
    private func participantPendingView(_ participant: ParticipantModel, strokeColor: Color) -> some View {
        Text("\(participant.nickName) 도전 중 😀")
            .font(YDSFont.body1)
            .padding(24)
            .frame(maxWidth: .infinity, maxHeight: 70, alignment: .leading)
            .background(.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(strokeColor, style: .init(lineWidth: 2, dash: [5]))
            )
    }
    @ViewBuilder
    private func participantFailureView(_ participant: ParticipantModel) -> some View {
        Text("\(participant.nickName) 실패 🥲")
        .font(YDSFont.body1)
        .foregroundStyle(Color.gray)
        .padding(24)
        .frame(maxWidth: .infinity, maxHeight: 70, alignment: .leading)
        .background(.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, style: .init(lineWidth: 2))
        )
    }
}
