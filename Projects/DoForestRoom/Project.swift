import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.product(
    name: "DoForestRoom",
    platform: .iOS,
    additionalDependency: [
        "DoForestCore",
        "DoForestUI",
        "DoForestNetwork"
    ],
    additionalInterfaceDependency: []
)
