//
//  RoomUsecaseImpl.swift
//  RoomDomain
//
//  Created by 정종인 on 10/3/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import Foundation
import ComposableArchitecture
import RoomDomainInterface

public struct RoomUsecaseImpl: RoomUsecase {
    public init() {}
    public func getRooms(uid: UUID) async -> [RoomModel] {
        print("get rooms!")
        return RoomModel.mockData
    }

    public func getParticipants(roomID: UUID) async -> [ParticipantModel] {
        print("get participants!")
        return ParticipantModel.mockData
    }
}
