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
            VStack {
                Text("룸 정보")
                Text("\(viewStore.roomModel.title)")
                Text("\(viewStore.roomModel.subTitle)")
            }
            .toolbarBackground(Color(hex: viewStore.roomModel.backgroundHexColor), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationTitle(viewStore.roomModel.title)
        }
    }
}
