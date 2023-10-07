//
//  BaseDIContainer.swift
//  DI
//
//  Created by 정종인 on 10/7/23.
//  Copyright © 2023 com.yourssu. All rights reserved.
//

import Foundation

public protocol DIRegisterable {
    mutating func register<T>(_ dependency: T)
}

public protocol DIResolvable {
    func resolve<T>() -> T
}

public protocol DIRemovable {
    mutating func remove<T>(_ dependency: T)
}

internal protocol DIContainable: DIRegisterable & DIResolvable & DIRemovable {
    static var shared: Self { get set }
    var dependencies: [String: Any] { get set }
}

extension DIContainable {
    mutating public func register<T>(_ dependency: T) {
        let key = String(describing: type(of: T.self))
        dependencies[key] = dependency
        print("register되었습니다 : key : \(key), dependency : \(dependency)")
    }
    mutating public func remove<T>(_ dependency: T) {
        let key = String(describing: type(of: T.self))
        dependencies.removeValue(forKey: key)
        print("\(key)가 삭제되었습니다.")
    }

    public func resolve<T>() -> T {
        let key = String(describing: type(of: T.self))
        let dependency = dependencies[key]

        precondition(dependency != nil, "\(key)는 register되지 않았어요. resolve 부르기전에 register 해주세요")

        return dependency as! T
    }
}

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








//public class DIContainer {
//    public static let shared = DIContainer()
//
//    private var dependencies = [String: Any]()
//
//    public init() {}
//
//    public func register<T>(_ dependency: T) {
//        let key = String(describing: type(of: T.self))
//        dependencies[key] = dependency
//        print("register되었습니다 : key : \(key), dependency : \(dependency)")
//    }
//
//    public func remove<T>(_ dependency: T) {
//        let key = String(describing: type(of: T.self))
//        dependencies.removeValue(forKey: key)
//        print("\(key)가 삭제되었습니다.")
//    }
//
//    public func resolve<T>() -> T {
//        let key = String(describing: type(of: T.self))
//        let dependency = dependencies[key]
//
//        precondition(dependency != nil, "\(key)는 register되지 않았어요. resolve 부르기전에 register 해주세요")
//
//        return dependency as! T
//    }
//}
//
//@propertyWrapper
//public class DIResolver<T> {
//    public let wrappedValue: T
//    public init() {
//        self.wrappedValue = DIContainer.shared.resolve()
//    }
//}
