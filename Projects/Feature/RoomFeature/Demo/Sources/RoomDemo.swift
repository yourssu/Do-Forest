import SwiftUI
import RoomFeature
import RoomFeatureInterface

@main
struct HomeDemo: App {
    var body: some Scene {
        WindowGroup {
            CustomRoomView(store: .init(initialState: CustomRoom.State(), reducer: {
                CustomRoom()
            }))
        }
    }
}
