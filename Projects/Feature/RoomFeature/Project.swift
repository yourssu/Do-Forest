import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.RoomFeature.rawValue,
    targets: [
        .interface(module: .feature(.RoomFeature), dependencies: [
            .shared(target: .GlobalThirdPartyLibrary),
            .domain(target: .RoomDomain, type: .interface),
            .shared(target: .Util),
            .shared(target: .DI)
        ]),
        .implements(module: .feature(.RoomFeature), dependencies: [
            .feature(target: .RoomFeature, type: .interface),
            .userInterface(target: .DesignSystem)
        ]),
        .testing(module: .feature(.RoomFeature), dependencies: [
            .feature(target: .RoomFeature, type: .interface),
            .domain(target: .RoomDomain)
        ]),
        .tests(module: .feature(.RoomFeature), dependencies: [
            .feature(target: .RoomFeature),
            .feature(target: .RoomFeature, type: .testing)
        ]),
        .demo(module: .feature(.RoomFeature), dependencies: [
            .feature(target: .RoomFeature),
            .feature(target: .RoomFeature, type: .testing)
        ])
    ]
)
