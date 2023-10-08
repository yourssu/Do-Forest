//
//  RoomDIContainer.swift
//  DI
//
//  Created by 정종인 on 10/7/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

public struct RoomDIContainer: DIContainable {
    public static var shared = RoomDIContainer()
    var dependencies: [String: Any] = [:]
}

@propertyWrapper
public class RoomDIResolver<T> {
    public let wrappedValue: T
    public init() {
        self.wrappedValue = RoomDIContainer.shared.resolve()
    }
}
