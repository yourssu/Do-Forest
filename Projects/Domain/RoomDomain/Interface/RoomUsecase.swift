//
//  RoomUsecase.swift
//  RoomDomainInterface
//
//  Created by 정종인 on 10/3/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import Foundation

public protocol RoomUsecase {
    func getRooms(uid: UUID) async -> [RoomModel]
    func getParticipants(roomID: UUID) async -> [ParticipantModel]
}
