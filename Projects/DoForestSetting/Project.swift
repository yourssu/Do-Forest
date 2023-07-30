import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.product(
    name: "DoForestSetting",
    platform: .iOS,
    additionalDependency: [
        "DoForestCore",
        "DoForestUI",
        "DoForestNetwork"
    ],
    additionalInterfaceDependency: []
)
