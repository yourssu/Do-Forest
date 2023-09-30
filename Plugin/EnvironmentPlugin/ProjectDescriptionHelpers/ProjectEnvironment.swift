import Foundation
import ProjectDescription

public struct ProjectEnvironment {
    public let name: String
    public let organizationName: String
    public let deploymentTarget: DeploymentTarget
    public let platform: Platform
    public let baseSetting: SettingsDictionary
}

public let env = ProjectEnvironment(
    name: "DoForest",
    organizationName: "com.yourssu",
    deploymentTarget: .iOS(targetVersion: "16.0", devices: [.iphone, .ipad]),
    platform: .iOS,
    baseSetting: [:]
)
