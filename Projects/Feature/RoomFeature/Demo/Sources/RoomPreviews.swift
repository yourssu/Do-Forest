//
//  RoomPreviews.swift
//  RoomFeatureDemo
//
//  Created by 정종인 on 10/3/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import SwiftUI
import RoomFeature
import RoomFeatureInterface
import RoomFeatureTesting

#Preview {
    registerRoomTestDependency()
    return CustomRoomView(store: .init(initialState: CustomRoom.State(roomModel: .default()), reducer: {
        CustomRoom()
    }))
}
