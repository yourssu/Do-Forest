import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Domain.RoomDomain.rawValue,
    targets: [
        .interface(module: .domain(.RoomDomain)),
        .implements(module: .domain(.RoomDomain), dependencies: [
            .domain(target: .RoomDomain, type: .interface)
        ]),
        .testing(module: .domain(.RoomDomain), dependencies: [
            .domain(target: .RoomDomain, type: .interface)
        ]),
        .tests(module: .domain(.RoomDomain), dependencies: [
            .domain(target: .RoomDomain)
        ]),
        .demo(module: .domain(.RoomDomain), dependencies: [
            .domain(target: .RoomDomain)
        ])
    ]
)
