import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.BaseDomain.rawValue,
    targets: [
        .implements(module: .domain(.BaseDomain), dependencies: [
            .shared(target: .GlobalThirdPartyLibrary),
            .core(target: .Networking),
            .domain(target: .BaseDomain, type: .interface)
        ]),
        .tests(module: .domain(.BaseDomain), dependencies: [
            .domain(target: .BaseDomain)
        ]),
        .interface(module: .domain(.BaseDomain))
    ]
)
