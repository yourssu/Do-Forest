import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.product(
    name: "DoForestLogin",
    platform: .iOS,
    additionalDependency: [
        "DoForestCore",
        "DoForestUI",
        "DoForestNetwork"
    ],
    additionalInterfaceDependency: []
)
