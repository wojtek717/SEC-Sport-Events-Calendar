import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "EventCreator",
                                targets: [.framework],
                                packages: [],
                                externalDependencies: [],
                                internalDependencies: [
                                    "Core",
                                    "DesignSystem",
                                    "CommonUI",
                                    "Location",
                                    "Networking",
                                    "Authentication",
                                ],
                                resources: [.glob(pattern: "**/*.xib")])
