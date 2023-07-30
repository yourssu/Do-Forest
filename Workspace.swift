import ProjectDescription
import ProjectDescriptionHelpers

private let modules: [String] = [
    "DoForestApp",
    "DoForestLogin",
    "DoForestMain",
    "DoForestRoom",
    "DoForestSetting",
    "DoForestCore",
    "DoForestUI",
    "DoForestNetwork"
]

private let projects: [Path] = modules.map { "Projects/\($0)" }

private let workspace = Workspace(
    name: "\(projectName)",
    projects: projects
)
