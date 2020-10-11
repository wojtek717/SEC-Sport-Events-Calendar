import ProjectDescription

// More info: https://tuist.io/docs/architectures/microfeatures/

public enum uFeatureTarget {
    case framework
    case tests
    case examples
    case testing
}

extension Project {
    public static func framework(name: String,
                                 targets: Set<uFeatureTarget>,
                                 packages: [Package] = [],
                                 externalDependencies: [TargetDependency] = [],
                                 internalDependencies: [String] = [],
                                 sdks: [String] = [],
                                 resources: [FileElement] = [],
                                 withPublicResources: Bool = false,
                                 additionalPlistRows: [String: ProjectDescription.InfoPlist.Value] = [:]) -> Project {
        let disableDiamondProblemDiagnostic = [
            "DISABLE_DIAMOND_PROBLEM_DIAGNOSTIC": SettingValue(stringLiteral: "1"),
            "OTHER_LDFLAGS": "-ObjC",
            "EXCLUDED_ARCHS[sdk=iphonesimulator*]": SettingValue(stringLiteral: "arm64"),
        ]

        let frameworkConfigurations: [CustomConfiguration] = [
            .debug(name: "Debug", settings: disableDiamondProblemDiagnostic),
            .debug(name: "Release", settings: disableDiamondProblemDiagnostic)
        ]
        let testsConfigurations: [CustomConfiguration] = [
            .debug(name: "Debug", settings: disableDiamondProblemDiagnostic),
            .debug(name: "Release", settings: disableDiamondProblemDiagnostic)
        ]
        let appConfigurations: [CustomConfiguration] = [
            .debug(name: "Debug", settings: disableDiamondProblemDiagnostic),
            .debug(name: "Release", settings: disableDiamondProblemDiagnostic)
        ]

        let projectConfigurations: [CustomConfiguration] = [
            .debug(name: "Debug", settings: disableDiamondProblemDiagnostic),
            .debug(name: "Release", settings: disableDiamondProblemDiagnostic)
        ]

        let testsDependencies: [TargetDependency] = [
            .target(name: "\(name)"),
            .xctest
        ]

        // Target dependencies
        var targetDependencies: [TargetDependency] = internalDependencies.map { .project(target: $0, path: .relativeToRoot("SEC/\($0)")) }
        targetDependencies.append(contentsOf: sdks.map { .sdk(name: $0) })

        targetDependencies.append(contentsOf: [
            .package(product: "Rswift"),
            .package(product: "NeedleFoundation")
        ])
        targetDependencies.append(contentsOf: externalDependencies)

        var commonRows: [String: ProjectDescription.InfoPlist.Value] = ["CFBundleLocalizations": ["en"]]
        commonRows = commonRows.merging(additionalPlistRows) { $1 }

        // Project targets
        var projectTargets: [Target] = []
        if targets.contains(.framework) {
            projectTargets.append(Target(name: name,
                                         platform: .iOS,
                                         product: .framework,
                                         bundleId: "com.dev.sec.\(name)",
                                         deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                                         infoPlist: InfoPlist.extendingDefault(with: commonRows),
                                         sources: [
                                             "Sources/**/*.swift",
                                             "SupportingFiles/Generated/R.generated.swift",
                                             "SupportingFiles/Generated/Needle.generated.swift"
                                         ],
                                         resources: resources,
                                         actions: [
                                             .pre(path: .relativeToRoot(withPublicResources ? "Scripts/rswift_public.sh" : "Scripts/rswift.sh"),
                                                  arguments: [],
                                                  name: "R.swift",
                                                  inputPaths: ["$TEMP_DIR/rswift-lastrun"],
                                                  inputFileListPaths: [],
                                                  outputPaths: ["SupportingFiles/Generated/R.generated.swift"],
                                                  outputFileListPaths: []),
                                             .pre(path: .relativeToRoot("Scripts/generate_needle.sh"),
                                                  arguments: ["SupportingFiles/Generated", "Sources"],
                                                  name: "Needle"),
                                             .post(path: .relativeToRoot("Scripts/swiftlint.sh"),
                                                   arguments: [],
                                                   name: "Swiftlint")
                                         ],
                                         dependencies: targetDependencies,
                                         settings: Settings(configurations: frameworkConfigurations)))
        }
        if targets.contains(.testing) {
            projectTargets.append(Target(name: "\(name)Testing",
                                         platform: .iOS,
                                         product: .framework,
                                         bundleId: "com.dev.sec.\(name)Testing",
                                         deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
                                         infoPlist: .default,
                                         sources: "Testing/**/*.swift",
                                         dependencies: [.target(name: "\(name)")],
                                         settings: Settings(configurations: frameworkConfigurations)))
        }
        if targets.contains(.tests) {
            projectTargets.append(Target(name: "\(name)Tests",
                                         platform: .iOS,
                                         product: .unitTests,
                                         bundleId: "com.dev.sec.\(name)Tests",
                                         infoPlist: .default,
                                         sources: "Tests/**/*.swift",
                                         dependencies: testsDependencies,
                                         settings: Settings(configurations: testsConfigurations)))
        }
        if targets.contains(.examples) {
            projectTargets.append(Target(name: "\(name)Example",
                                         platform: .iOS,
                                         product: .app,
                                         bundleId: "com.dev.sec.\(name)Examples",
                                         deploymentTarget: .iOS(targetVersion: "13.0", devices: .iphone),
                                         infoPlist: .default,
                                         sources: "Examples/Sources/**/*.swift",
                                         resources: resources,
                                         dependencies: [.target(name: "\(name)")],
                                         settings: Settings(configurations: appConfigurations)))
        }

        var projecPackages: [Package] = [
            .package(url: "https://github.com/mac-cain13/R.swift.Library", from: "5.1.0"),
            .package(url: "https://github.com/mac-cain13/R.swift", from: "5.1.0"),
            .package(url: "https://github.com/uber/needle", from: "0.15.0")
        ]

        projecPackages.append(contentsOf: packages)

        // Project
        return Project(name: name,
                       packages: projecPackages,
                       settings: Settings(configurations: projectConfigurations),
                       targets: projectTargets)
    }
}
