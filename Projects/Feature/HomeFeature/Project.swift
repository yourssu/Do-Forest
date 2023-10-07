import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.HomeFeature.rawValue,
    targets: [
        .interface(module: .feature(.HomeFeature), dependencies: [
            .domain(target: .RoomDomain, type: .interface),
            .shared(target: .GlobalThirdPartyLibrary),
            .shared(target: .Util),
            .shared(target: .DI)
        ]),
        .implements(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature, type: .interface),
            .userInterface(target: .DesignSystem)
        ]),
        .testing(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature, type: .interface)
        ]),
        .tests(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature),
            .feature(target: .HomeFeature, type: .testing)
        ]),
        .demo(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature),
            .feature(target: .HomeFeature, type: .testing)
        ])
    ]
)
