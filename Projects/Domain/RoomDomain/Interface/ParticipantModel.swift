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

    public enum Status: Equatable {
        case success
        case failure
        case pending
        case excluded
    }

    public init(uid: UUID, nickName: String, status: Status) {
        self.uid = uid
        self.nickName = nickName
        self.status = status
    }
}

extension ParticipantModel: Identifiable {
    public var id: UUID {
        uid
    }

    public static func `default`() -> Self {
        .init(uid: UUID(), nickName: "Mosu", status: .success)
    }

    public static let mockData: [Self] = [
        .init(uid: UUID(), nickName: "Mosu", status: .success),
        .init(uid: UUID(), nickName: "Ted", status: .failure),
        .init(uid: UUID(), nickName: "Joni", status: .success),
        .init(uid: UUID(), nickName: "Eddy", status: .failure),
        .init(uid: UUID(), nickName: "Bibi", status: .success),
        .init(uid: UUID(), nickName: "Jayden", status: .failure),
        .init(uid: UUID(), nickName: "Obi", status: .success),
        .init(uid: UUID(), nickName: "Zoe", status: .failure),
        .init(uid: UUID(), nickName: "Sereal", status: .success),
        .init(uid: UUID(), nickName: "Lucy", status: .failure),
        .init(uid: UUID(), nickName: "Javier", status: .success),
        .init(uid: UUID(), nickName: "Ezi", status: .failure)
    ]
}
