import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "Profile",
                                targets: [.framework],
                                packages: [],
                                externalDependencies: [],
                                internalDependencies: [
                                    "Core",
                                    "DesignSystem",
                                    "CommonUI",
                                    "Networking",
                                    "Authentication",
                                ],
                                resources: [.glob(pattern: "**/*.xib")])
