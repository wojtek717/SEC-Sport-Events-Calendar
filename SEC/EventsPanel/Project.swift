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
                                    "Location"
                                ],
                                resources: [.glob(pattern: "**/*.xib")])
