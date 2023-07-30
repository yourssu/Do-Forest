import ProjectDescription
import ProjectDescriptionHelpers

private let modules: [String] = [
//    "Module1",
//    "Module2",
]

private let projects: [Path] = modules.map { "Projects/\($0)" }

private let workspace = Workspace(
    name: "\(projectName)",
    projects: projects
)
