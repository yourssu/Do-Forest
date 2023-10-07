import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.DI.rawValue,
    targets: [
        .implements(module: .shared(.DI))
    ]
)
