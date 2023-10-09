import ProjectDescription
import ConfigurationPlugin

let dependencies = Dependencies(
    carthage: nil,
    swiftPackageManager: SwiftPackageManagerDependencies(
        [
            .remote(url: "https://github.com/airbnb/lottie-ios.git", requirement: .exact("4.3.3")),
            .remote(url: "https://github.com/yourssu/YDS-iOS.git", requirement: .exact("3.0.0")),
            .remote(url: "https://github.com/pointfreeco/swift-composable-architecture.git", requirement: .exact("1.2.0")),
    
        ],
        baseSettings: .settings(
            configurations: [
                .debug(name: .dev),
                .debug(name: .stage),
                .release(name: .prod)
            ]
        )
    ),
    platforms: [.iOS]
)
