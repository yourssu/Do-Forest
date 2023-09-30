import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Feature.BaseFeature.rawValue,
    targets: [
        .implements(module: .feature(.BaseFeature), dependencies: [
            .userInterface(target: .DesignSystem),
            .shared(target: .GlobalThirdPartyLibrary),
            .domain(target: .BaseDomain, type: .interface),
            .feature(target: .BaseFeature, type: .interface)
        ]),
        .tests(module: .feature(.BaseFeature), dependencies: [
            .feature(target: .BaseFeature)
        ]),
        .interface(module: .feature(.BaseFeature))
    ]
)
