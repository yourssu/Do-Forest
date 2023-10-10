import ComposableArchitecture
import Foundation
import RoomDomainInterface
import Util
import DI

public struct Home: Reducer {
    public init() {}
    @RoomDIResolver var roomUseCase: RoomUsecase
    public struct State: Equatable {
        public init() {}
        public var rooms: [RoomModel]?
        public var settingIconAnimation = AnimationValue()
        public var floatingButtonAnimation = AnimationValue()
        public var isPopupPresenting: Bool = false
        public var isEntering: Bool = false
        public var enterRoomPopup: EnterRoomPopup.State?
    }
    public enum Action: Equatable {
        case loadRooms
        case loadRoomsFinished([RoomModel])
        case settingButtonTapped
        case floatingButtonTapped
        case closeButtonTapped
        case enterCodeButtonTapped
        case enterRoomPopup(EnterRoomPopup.Action)
        case createRoomButtonTapped
        case enterRoom(RoomModel)
    }

    public var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .loadRooms:
                return .run { send in
                    let rooms = try await roomUseCase.getRooms(uid: UUID())
                    await send(.loadRoomsFinished(rooms), animation: .bouncy)
                }
            case .loadRoomsFinished(let rooms):
                if state.rooms != rooms {
                    hapticNotification(.success)
                }
                state.rooms = rooms
                return .none
            case .settingButtonTapped:
                state.settingIconAnimation.trigger()
                return .none
            case .floatingButtonTapped:
                hapticImpact(.soft)
                state.floatingButtonAnimation.trigger()
                state.isPopupPresenting = true
                return .none
            case .closeButtonTapped:
                state.isPopupPresenting = false
                state.isEntering = false
                return .run { send in
                    await send(.loadRooms)
                }
            case .enterCodeButtonTapped:
                state.isEntering = true
                return .none
            case .enterRoomPopup(.loadCompleted(true)):
                return .concatenate(.run { send in
                    await send(.closeButtonTapped)
                })
            case .createRoomButtonTapped:
                state.isPopupPresenting = false
                return .none
            case .enterRoom:
                hapticImpact(.light)
                return .none
            default:
                return .none
            }
        }
        .ifLet(\.enterRoomPopup, action: /Action.enterRoomPopup) {
            EnterRoomPopup()
        }
    }
}

public struct EnterRoomPopup: Reducer {
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
