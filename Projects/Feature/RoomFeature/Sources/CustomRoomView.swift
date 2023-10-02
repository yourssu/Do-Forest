import SwiftUI
import ComposableArchitecture
import YDS_SwiftUI
import RoomFeatureInterface

public struct CustomRoomView: View {
    public init(store: StoreOf<CustomRoom>) {
        self.store = store
    }
    public let store: StoreOf<CustomRoom>
    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            Text("\(viewStore.text)")
            Button {
                viewStore.send(.buttonTapped)
            } label: {
                Text("Button!")
            }

        }
    }
}

#Preview {
    CustomRoomView(store: .init(initialState: CustomRoom.State(), reducer: {
        CustomRoom()
    }))
}
