//
//  RoomDI.swift
//  DoForest
//
//  Created by 정종인 on 10/7/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import DI
import RoomDomain
import RoomDomainInterface

internal func registerRoomDependency() {
    RoomDIContainer.shared.register(RoomUsecaseImpl() as RoomUsecase)
}
