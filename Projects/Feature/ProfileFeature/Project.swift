import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.ProfileFeature.rawValue,
    targets: [
        .interface(module: .feature(.ProfileFeature), dependencies: [
            .domain(target: .ProfileDomain, type: .interface),
            .shared(target: .GlobalThirdPartyLibrary),
            .shared(target: .Util),
            .shared(target: .DI)
        ]),
        .implements(module: .feature(.ProfileFeature), dependencies: [
            .feature(target: .ProfileFeature, type: .interface),
            .userInterface(target: .DesignSystem)
        ]),
        .testing(module: .feature(.ProfileFeature), dependencies: [
            .feature(target: .ProfileFeature, type: .interface)
        ]),
        .tests(module: .feature(.ProfileFeature), dependencies: [
            .feature(target: .ProfileFeature),
            .feature(target: .ProfileFeature, type: .testing)
        ]),
        .demo(module: .feature(.ProfileFeature), dependencies: [
            .feature(target: .ProfileFeature),
            .feature(target: .ProfileFeature, type: .testing)
        ])
    ]
)
