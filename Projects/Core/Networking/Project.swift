import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Core.Networking.rawValue,
    targets: [
        .implements(module: .core(.Networking)),
        .tests(module: .core(.Networking), dependencies: [])
    ]
)
