import ComposableArchitecture
import RoomDomainInterface
import DesignSystem

public struct Home: Reducer {
    public init() {}
    public struct State: Equatable {
        public init() {}
        public var rooms: [RoomModel] = RoomModel.mockData
        public var settingIconAnimation = AnimationValue()
        public var floatingButtonAnimation = AnimationValue()
        public var isPopupPresenting: Bool = false
        public var isEntering: Bool = false
        public var enterRoom: EnterRoom.State? = .init()
    }
    public enum Action: Equatable {
        case buttonTapped
        case settingButtonTapped
        case floatingButtonTapped
        case closeButtonTapped
        case enterCodeButtonTapped
        case enterRoom(EnterRoom.Action)
        case createRoomButtonTapped
    }

    public var body: some Reducer<State, Action> {
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
            case .enterRoom(.loadCompleted(true)):
                return .concatenate(.run { send in
                    await send(.closeButtonTapped)
                })
            case .createRoomButtonTapped:
                state.isPopupPresenting = false
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.enterRoom, action: /Action.enterRoom) {
            EnterRoom()
        }
    }
}

public struct EnterRoom: Reducer {
    public init() {}
    public struct State: Equatable {
        public init() {}
        @BindingState public var text = ""
        public var isActivityIndicatorVisible = false
    }
    public enum Action: BindableAction, Equatable {
        case binding(BindingAction<State>)
        case submitButtonTapped
        case activityIndicatorVisible(Bool)
        case loadCompleted(Bool)
        case navigateToCustomRoom
    }
    @Dependency(\.continuousClock) var clock

    private enum CancelID { case load }

    public var body: some Reducer<State, Action> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .cancel(id: CancelID.load)
            case .submitButtonTapped:
                return .run { send in
                    await send(.activityIndicatorVisible(true), animation: .bouncy)
                    try await self.clock.sleep(for: .seconds(1))
                    await send(.loadCompleted(true))
                }
                .cancellable(id: CancelID.load)
            case .activityIndicatorVisible(let isVisible):
                state.isActivityIndicatorVisible = isVisible
                return .none
            case .loadCompleted(let isSuccessed):
                state.isActivityIndicatorVisible = false
                if !isSuccessed {
                    return .cancel(id: CancelID.load)
                }
                return .run { send in
                    await send(.navigateToCustomRoom)
                }
                .merge(with: .cancel(id: CancelID.load))
            case .navigateToCustomRoom:
                print("navigate To Custom Room!!")
                return .none
            }
        }
    }
}
