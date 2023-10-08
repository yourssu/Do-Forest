import ComposableArchitecture
import RoomDomainInterface
import DI
import Util

public struct CustomRoom: Reducer {
    public init() {}
    public struct State: Equatable {
        public init(roomModel: RoomModel) {
            self.roomModel = roomModel
        }
        public var roomModel: RoomModel
        public var participants: [ParticipantModel] = []
        public var isExpandSuccess: Bool = true
        public var isExpandPending: Bool = true
        public var isExpandFailure: Bool = true
    }
    public enum Action: Equatable {
        case loadParticipants
        case loadParticipantsFinished([ParticipantModel])
        case toggleExpand(ParticipantModel.Status)
    }

    @RoomDIResolver private var roomUsecase: RoomUsecase
    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadParticipants:
                return .run { [id = state.roomModel.id] send in
                    let participants = try await roomUsecase.getParticipants(roomID: id)
                    await send(.loadParticipantsFinished(participants), animation: .bouncy)
                }
            case .loadParticipantsFinished(let participants):
                if state.participants != participants {
                    hapticNotification(.success)
                }
                state.participants = participants
                return .none
            case .toggleExpand(let status):
                hapticImpact(.soft)
                switch status {
                case .success:
                    state.isExpandSuccess.toggle()
                case .pending:
                    state.isExpandPending.toggle()
                case .failure:
                    state.isExpandFailure.toggle()
                default:
                    break
                }
                return .none
            }
        }
    }
}
