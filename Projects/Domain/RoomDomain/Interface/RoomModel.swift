import Foundation

public struct RoomModel: Equatable, Identifiable {
    public let id: UUID
    public let title: String
    public let subTitle: String
    public let icon: String
    public let backgroundHexColor: UInt
    public let roomType: RoomType

    public enum RoomType: Equatable, CaseIterable {
        case custom
        case github

        public var title: String {
            switch self {
            case .custom:
                "Custom"
            case .github:
                "Github"
            }
        }

        public var subTitle: String {
            switch self {
            case .custom:
                "직접 방을 커스텀 할 수 있어요"
            case .github:
                "깃허브 잔디를 보여줄 수 있어요"
            }
        }
    }

    public init(id: UUID, title: String, subTitle: String, icon: String, backgroundHexColor: UInt, roomType: RoomType) {
        self.id = id
        self.title = title
        self.subTitle = subTitle
        self.icon = icon
        self.backgroundHexColor = backgroundHexColor
        self.roomType = roomType
    }
}

public extension RoomModel {
    static func `default`() -> Self {
        .init(
            id: UUID(),
            title: "",
            subTitle: "",
            icon: "",
            backgroundHexColor: 0x000000,
            roomType: .custom
        )
    }
    static let mockData: [Self] = [
        .init(
            id: UUID(),
            title: "망한 잔디밭 살리기",
            subTitle: "1일 1잔디심기 프로젝트.\n삭막한 잔디밭 살려.",
            icon: "🌿",
            backgroundHexColor: 0x72C381,
            roomType: .custom
        ),
        .init(
            id: UUID(),
            title: "모수의 잔디밭",
            subTitle: "짱아요에서 살아남기... 그를 이겨라",
            icon: "❤️‍🔥",
            backgroundHexColor: 0xE27488,
            roomType: .custom
        ),
        .init(
            id: UUID(),
            title: "테드의 험난한 대학생활",
            subTitle: "잔디를 살려보자.",
            icon: "📚",
            backgroundHexColor: 0x747FE2,
            roomType: .custom
        ),
        .init(
            id: UUID(),
            title: "오전 잔디심기 인증",
            subTitle: "기상 시간 인증 스터디",
            icon: "☀️",
            backgroundHexColor: 0xEEA418,
            roomType: .custom
        ),
        .init(
            id: UUID(),
            title: "알고리즘 공부하자",
            subTitle: "알고리즘으로만 잔디 채워보기",
            icon: "🗂️",
            backgroundHexColor: 0xA574E2,
            roomType: .custom
        )
    ]
}
