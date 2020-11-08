import ProjectDescription
import ProjectDescriptionHelpers

let diamondProblemDiagnostic = ["DISABLE_DIAMOND_PROBLEM_DIAGNOSTIC": SettingValue(stringLiteral: "1")]
let excludeArchArm64 = ["EXCLUDED_ARCHS[sdk=iphonesimulator*]": SettingValue(stringLiteral: "arm64")]

let iosConfigurations: [CustomConfiguration] = [
    .debug(
        name: "Debug",
        settings: SettingsDictionary()
            .codeSignIdentityAppleDevelopment()
            .merging(excludeArchArm64)
            .merging(diamondProblemDiagnostic),
        xcconfig: .relativeToCurrentFile("SupportingFiles/Configuration/Debug.xcconfig")),
]

let iosSettings = Settings(configurations: iosConfigurations)

let iosTarget = Target(name: "SEC",
                       platform: .iOS,
                       product: .app,
                       bundleId: "$(PRODUCT_BUNDLE_IDENTIFIER)",
                       deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
                       infoPlist: .file(path: .relativeToRoot("SEC/App/SEC/SupportingFiles/Development/Info.plist")),
                       sources: SourceFilesList(globs: [SourceFileGlob("SEC/**")]),
                       resources: [
                        .glob(pattern: "SEC/Resources/**"),
                        "SupportingFiles/**",
                       ],
                       dependencies: [
                        .project(target: "Core", path: "../Core"),
                        .project(target: "DesignSystem", path: "../DesignSystem"),
                        .project(target: "Splash", path: "../Splash"),
                        .sdk(name: "UIKit.framework"),
                        .package(product: "NeedleFoundation"),
                       ],
                       settings: iosSettings)

let project = Project(
    name: "SEC",
    packages: [
        .package(url: "https://github.com/uber/needle", from: "0.15.0"),
    ],
    settings: iosSettings,
    targets: [iosTarget],
    additionalFiles: [])
