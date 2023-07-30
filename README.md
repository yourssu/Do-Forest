# Tuist-MicroFeatures-Architecture
Template of MicroFeatures Architecture with Tuist & SwiftUI

## Summary
- SwiftUI
- µFeature Architecture
- Tuist (modularization, scaffold) (version 3.17.0)
- Core Data
- Unit Test

## How to use this template
1. Use this template or download this repository
2. Add modules with `tuist scaffold`
    - `tuist scaffold app --name MyApp` : add App feature
    - `tuist scaffold product --name MyFeature1` : add Product feature
    - `tuist scaffold foundation --name CoreFeature` : add Foundation feature
3. Execute `tuist edit`
4. Add module name to `Workspace.swift`
    - `private let modules: [String] = ["MyApp", "MyFeature1", "CoreFeature"]`
5. Add dependencies in `{Module Name}/Project.swift`
    - `let project = Project.product(name: "MyApp", platform: .iOS, additionalDependency: ["MyFeature1"])`
    - `let project = Project.product(name: "MyFeature1", platform: .iOS, additionalDependency: ["CoreFeature"], additionalInterfaceDependency: [/*"MyFeature2"*/])`
    - `let project = Project.foundation(name: "CoreFeature", platform: .iOS, additionalDependency: [], additionalInterfaceDependency: [])`
    - If the module uses core data, use `Project.coreDataFoundation` : `let project = Project.coreDataFoundation(name: "FeatureWithCoreData", platform: .iOS, additionalDependency: [], additionalInterfaceDependency: [], coreDataModels: ["ModelName"])`
6. Execute `tuist generate`

## Rules
There are 3 feature types : App, Product, Foundation (ref. https://docs.tuist.io/building-at-scale/microfeatures)

1. Features with the same type should be connected in parallel.
2. When depending on a different feature type, the Interface module of the current Feature depends on the Source of that Feature.
3. When depending on the same feature type, the Source module of the current Feature depends on the Interface of the other Feature.
4. There should be only one App Feature Type.

Each Feature's internal target is dependent as follows.
![image](https://github.com/chongin12/Tuist-MicroFeatures-Architecture/assets/19565940/b6dbc129-0910-4362-8584-aecb955b662d)

