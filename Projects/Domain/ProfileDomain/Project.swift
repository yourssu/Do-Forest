import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.ProfileDomain.rawValue,
    targets: [
        .interface(module: .domain(.ProfileDomain)),
        .implements(module: .domain(.ProfileDomain), dependencies: [
            .domain(target: .ProfileDomain, type: .interface)
        ]),
        .testing(module: .domain(.ProfileDomain), dependencies: [
            .domain(target: .ProfileDomain, type: .interface)
        ]),
        .tests(module: .domain(.ProfileDomain), dependencies: [
            .domain(target: .ProfileDomain),
            .domain(target: .ProfileDomain, type: .testing)
        ]),
        .demo(module: .domain(.ProfileDomain), dependencies: [
            .domain(target: .ProfileDomain),
            .domain(target: .ProfileDomain, type: .testing)
        ])
    ]
)
