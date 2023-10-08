//
//  RoomUsecaseImpl.swift
//  RoomDomain
//
//  Created by 정종인 on 10/3/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import Foundation
import RoomDomainInterface

public struct RoomUsecaseImpl: RoomUsecase {
    public init() {}
    public func getRooms(uid: UUID) async throws -> [RoomModel] {
        print("get rooms!")
        try await Task.sleep(until: .now + .seconds(1.5), clock: .continuous)
        print("get rooms completed!")
        return RoomModel.mockData
    }

    public func getParticipants(roomID: UUID) async throws -> [ParticipantModel] {
        print("get participants!")
        try await Task.sleep(until: .now + .seconds(1.5), clock: .continuous)
        print("get participants completed!")
        return ParticipantModel.mockData
    }
}
