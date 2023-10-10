import SwiftUI
import RoomFeature
import RoomFeatureInterface

@main
struct RoomDemo: App {
    var body: some Scene {
        WindowGroup {
            CustomRoomView(store: .init(initialState: CustomRoom.State(roomModel: .default()), reducer: {
                CustomRoom()
            }))
        }
    }
}
