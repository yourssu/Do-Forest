import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.app(
    name: "DoForestApp",
    platform: .iOS,
    additionalDependency: [
        "DoForestLogin",
        "DoForestMain",
        "DoForestRoom",
        "DoForestSetting"
    ]
)
