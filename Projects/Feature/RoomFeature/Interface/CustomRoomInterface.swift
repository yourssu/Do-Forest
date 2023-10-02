import ComposableArchitecture
public struct CustomRoom: Reducer {
    public init() {}
    public struct State: Equatable {
        public init() {}
        public var text: String = "Cutom Room 화면입니다."
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
