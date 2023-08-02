import ProjectDescription

/// Project helpers are functions that simplify the way you define your project.
/// Share code to create targets, settings, dependencies,
/// Create your own conventions, e.g: a func that makes sure all shared targets are "static frameworks"
/// See https://docs.tuist.io/guides/helpers/
///
///

public let projectName: String = "DoForest"
public let organization: String = "com.yourssu"

private let infoPlist: [String: InfoPlist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "UIMainStoryboardFile": "",
    "UILaunchStoryboardName": "LaunchScreen"
]

let testsConfigurations: [Configuration] = [
    .debug(name: "Debug", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
    .debug(name: "Release", settings: [String: SettingValue](), xcconfig: .relativeToRoot("Configurations/iOS/iOS-Base.xcconfig")),
]

extension Project {
    public static func app(name: String, platform: Platform = .iOS, additionalDependency: [String]) -> Project {
        var targets: [Target] = [
            Target(name: "\(name)Tests",
                   platform: .iOS,
                   product: .unitTests,
                   bundleId: "\(organization).\(name)Tests",
                   infoPlist: .default,
                   sources: ["Tests/**"],
                   resources: ["Tests/Resources/**"],
                   dependencies: [
                    .target(name: "\(name)"),
                    .xctest
                   ],
                   settings: Settings.settings(configurations: testsConfigurations)
                  ),
            Target(name: "\(name)",
                   platform: .iOS,
                   product: .app,
                   bundleId: "\(organization).\(name)",
                   infoPlist: .extendingDefault(with: infoPlist),
                   sources: ["Sources/**"],
                   resources: ["Sources/Resources/**"],
                   dependencies: [] + additionalDependency.map { .project(target: $0, path: "../\($0)") }
                  ),
        ]
        return Project(name: name,
                       organizationName: organization,
                       targets: targets)
    }
    
    public static func product(name: String, platform: Platform = .iOS, additionalDependency: [String], additionalInterfaceDependency: [String]) -> Project {
        var targets: [Target] = [
            Target(name: "\(name)Example",
                   platform: .iOS,
                   product: .app,
                   bundleId: "\(organization).\(name)Example",
                   infoPlist: .extendingDefault(with: infoPlist),
                   sources: ["Example/**"],
                   resources: ["Example/Resources/**"],
                   dependencies: [
                    .target(name: "\(name)"),
                    .target(name: "\(name)Testing")
                   ]
                  ),
            Target(name: "\(name)Tests",
                   platform: .iOS,
                   product: .unitTests,
                   bundleId: "\(organization).\(name)Tests",
                   infoPlist: .default,
                   sources: ["Tests/**"],
                   resources: ["Tests/Resources/**"],
                   dependencies: [
                    .target(name: "\(name)"),
                    .target(name: "\(name)Testing"),
                    .xctest
                   ],
                   settings: Settings.settings(configurations: testsConfigurations)
                  ),
            Target(name: "\(name)Testing",
                   platform: .iOS,
                   product: .framework,
                   bundleId: "\(organization).\(name)Testing",
                   infoPlist: .default,
                   sources: ["Testing/**"],
                   dependencies: [
                    .target(name: "\(name)Interface")
                   ]
                  ),
            Target(name: "\(name)",
                   platform: .iOS,
                   product: .framework,
                   bundleId: "\(organization).\(name)",
                   infoPlist: .default,
                   sources: ["Sources/**"],
                   resources: ["Sources/Resources/**"],
                   dependencies: [
                    .target(name: "\(name)Interface")
                   ] + additionalInterfaceDependency.map { .project(target: "\($0)Interface", path: "../\($0)") }
                  ),
            Target(name: "\(name)Interface",
                   platform: .iOS,
                   product: .framework,
                   bundleId: "\(organization).\(name)Interface",
                   infoPlist: .default,
                   sources: ["Interface/**"],
                   dependencies: []
                   + additionalDependency.map { .project(target: "\($0)", path: "../\($0)") }
                  ),
        ]
        return Project(name: name,
                       organizationName: organization,
                       targets: targets)
    }
    
    public static func foundation(name: String, platform: Platform = .iOS, additionalDependency: [String], additionalInterfaceDependency: [String]) -> Project {
        var targets: [Target] = [
            Target(name: "\(name)Example",
                   platform: .iOS,
                   product: .app,
                   bundleId: "\(organization).\(name)Example",
                   infoPlist: .extendingDefault(with: infoPlist),
                   sources: ["Example/**"],
                   resources: ["Example/Resources/**"],
                   dependencies: [
                    .target(name: "\(name)"),
                    .target(name: "\(name)Testing")
                   ]
                  ),
            Target(name: "\(name)Tests",
                   platform: .iOS,
                   product: .unitTests,
                   bundleId: "\(organization).\(name)Tests",
                   infoPlist: .default,
                   sources: ["Tests/**"],
                   resources: ["Tests/Resources/**"],
                   dependencies: [
                    .target(name: "\(name)"),
                    .target(name: "\(name)Testing"),
                    .xctest
                   ],
                   settings: Settings.settings(configurations: testsConfigurations)
                  ),
            Target(name: "\(name)Testing",
                   platform: .iOS,
                   product: .framework,
                   bundleId: "\(organization).\(name)Testing",
                   infoPlist: .default,
                   sources: ["Testing/**"],
                   dependencies: [
                    .target(name: "\(name)Interface")
                   ]
                  ),
            Target(name: "\(name)",
                   platform: .iOS,
                   product: .framework,
                   bundleId: "\(organization).\(name)",
                   infoPlist: .default,
                   sources: ["Sources/**"],
                   resources: ["Sources/Resources/**"],
                   dependencies: [
                    .target(name: "\(name)Interface")
                   ]
                   + additionalInterfaceDependency.map { .project(target: "\($0)Interface", path: "../\($0)") }
                  ),
            Target(name: "\(name)Interface",
                   platform: .iOS,
                   product: .framework,
                   bundleId: "\(organization).\(name)Interface",
                   infoPlist: .default,
                   sources: ["Interface/**"],
                   dependencies: []
                   + additionalDependency.map { .project(target: "\($0)", path: "../\($0)") }
                  ),
        ]
        return Project(name: name,
                       organizationName: organization,
                       targets: targets)
    }
    
    public static func coreDataFoundation(name: String, platform: Platform = .iOS, additionalDependency: [String], additionalInterfaceDependency: [String], coreDataModels: [String]) -> Project {
        var targets: [Target] = [
            Target(name: "\(name)Example",
                   platform: .iOS,
                   product: .app,
                   bundleId: "\(organization).\(name)Example",
                   infoPlist: .extendingDefault(with: infoPlist),
                   sources: ["Example/**"],
                   resources: ["Example/Resources/**"],
                   dependencies: [
                    .target(name: "\(name)"),
                    .target(name: "\(name)Testing")
                   ]
                  ),
            Target(name: "\(name)Tests",
                   platform: .iOS,
                   product: .unitTests,
                   bundleId: "\(organization).\(name)Tests",
                   infoPlist: .default,
                   sources: ["Tests/**"],
                   resources: ["Tests/Resources/**"],
                   dependencies: [
                    .target(name: "\(name)"),
                    .target(name: "\(name)Testing"),
                    .xctest
                   ],
                   settings: Settings.settings(configurations: testsConfigurations)
                  ),
            Target(name: "\(name)Testing",
                   platform: .iOS,
                   product: .framework,
                   bundleId: "\(organization).\(name)Testing",
                   infoPlist: .default,
                   sources: ["Testing/**"],
                   dependencies: [
                    .target(name: "\(name)Interface")
                   ]
                  ),
            Target(name: "\(name)",
                   platform: .iOS,
                   product: .framework,
                   bundleId: "\(organization).\(name)",
                   infoPlist: .default,
                   sources: ["Sources/**"],
                   resources: ["Sources/Resources/**"],
                   dependencies: [
                    .target(name: "\(name)Interface")
                   ]
                   + additionalInterfaceDependency.map { .project(target: "\($0)Interface", path: "../\($0)") }
                  ),
            Target(name: "\(name)Interface",
                   platform: .iOS,
                   product: .framework,
                   bundleId: "\(organization).\(name)Interface",
                   infoPlist: .default,
                   sources: ["Interface/**"],
                   dependencies: []
                   + additionalDependency.map { .project(target: "\($0)", path: "../\($0)") },
                   coreDataModels: coreDataModels.map { .init("Interface/\($0).xcdatamodeld") }
                  ),
        ]
        return Project(name: name,
                       organizationName: organization,
                       targets: targets)
    }
}
