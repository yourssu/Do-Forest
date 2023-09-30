import DependencyPlugin
import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.module(
    name: ModulePaths.Shared.Util.rawValue,
    targets: [
        .implements(module: .shared(.Util))
    ]
)
