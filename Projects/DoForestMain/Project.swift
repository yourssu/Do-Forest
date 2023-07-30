import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.product(
    name: "DoForestMain",
    platform: .iOS,
    additionalDependency: [
        "DoForestCore",
        "DoForestUI",
        "DoForestNetwork"
    ],
    additionalInterfaceDependency: [
        "DoForestRoom",
        "DoForestSetting"
    ]
)
