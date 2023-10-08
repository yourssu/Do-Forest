//
//  ParticipantsModel.swift
//  RoomDomainInterface
//
//  Created by 정종인 on 10/3/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import Foundation

public struct ParticipantModel: Equatable {
    public let uid: UUID
    public let nickName: String
    public let status: Status
    public let strick: Int

    public enum Status: Equatable {
        case success
        case failure
        case pending
        case excluded
    }

    public init(uid: UUID, nickName: String, status: Status, strick: Int) {
        self.uid = uid
        self.nickName = nickName
        self.status = status
        self.strick = strick
    }
}

extension ParticipantModel: Identifiable {
    public var id: UUID {
        uid
    }

    public static func `default`() -> Self {
        .init(uid: UUID(), nickName: "Mosu", status: .success, strick: 2)
    }

    public static let mockData: [Self] = [
        .init(uid: UUID(), nickName: "Mosu", status: .success, strick: 2),
        .init(uid: UUID(), nickName: "Ted", status: .pending, strick: 3),
        .init(uid: UUID(), nickName: "Joni", status: .success, strick: 4),
        .init(uid: UUID(), nickName: "Eddy", status: .failure, strick: 0),
        .init(uid: UUID(), nickName: "Bibi", status: .success, strick: 10),
        .init(uid: UUID(), nickName: "Jayden", status: .pending, strick: 22),
        .init(uid: UUID(), nickName: "Obi", status: .success, strick: 200),
        .init(uid: UUID(), nickName: "Zoe", status: .failure, strick: 0),
        .init(uid: UUID(), nickName: "Sereal", status: .pending, strick: 23),
        .init(uid: UUID(), nickName: "Lucy", status: .failure, strick: 0),
        .init(uid: UUID(), nickName: "Javier", status: .success, strick: 2000),
        .init(uid: UUID(), nickName: "Ezi", status: .pending, strick: 20000)
    ]
}
