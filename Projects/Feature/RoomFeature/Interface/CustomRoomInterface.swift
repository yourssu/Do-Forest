import ComposableArchitecture
public struct CustomRoom: Reducer {
    public init() {}
    public struct State: Equatable {
        public init(text: String = "") {
            self.text = text
        }
        public var text: String = ""
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
