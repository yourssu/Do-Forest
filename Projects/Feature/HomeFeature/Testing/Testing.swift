import DI
import RoomDomain
import RoomDomainInterface
public func registerRoomTestDependency() {
    RoomDIContainer.shared.register(RoomUsecaseImpl() as RoomUsecase)
}
