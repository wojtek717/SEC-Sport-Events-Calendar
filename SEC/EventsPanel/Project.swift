import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "EventsPanel",
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
