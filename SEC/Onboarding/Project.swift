import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "Onboarding",
                                targets: [.framework],
                                packages: [],
                                externalDependencies: [],
                                internalDependencies: [
                                    "Core",
                                    "DesignSystem",
                                    "CommonUI",
                                ],
                                resources: [.glob(pattern: "**/*.xib")])
