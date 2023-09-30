import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.HomeFeature.rawValue,
    targets: [
        .interface(module: .feature(.HomeFeature)),
        .implements(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature, type: .interface),
            .shared(target: .GlobalThirdPartyLibrary)
        ]),
        .testing(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature, type: .interface)
        ]),
        .tests(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature)
        ]),
        .demo(module: .feature(.HomeFeature), dependencies: [
            .feature(target: .HomeFeature)
        ])
    ]
)
