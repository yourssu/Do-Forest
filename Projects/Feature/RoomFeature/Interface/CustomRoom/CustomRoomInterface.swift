import ComposableArchitecture
import RoomDomainInterface
public struct CustomRoom: Reducer {
    public init() {}
    public struct State: Equatable {
        public init(roomModel: RoomModel) {
            self.roomModel = roomModel
        }
        public var roomModel: RoomModel
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
