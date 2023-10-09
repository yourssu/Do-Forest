import ProjectDescription

public extension TargetDependency {
    struct SPM {}
}

public extension TargetDependency.SPM {
    static let Lottie = TargetDependency.external(name: "Lottie")
    static let YDS = TargetDependency.external(name: "YDS-SwiftUI")
    static let TCA = TargetDependency.external(name: "ComposableArchitecture")
}

public extension Package {
}
