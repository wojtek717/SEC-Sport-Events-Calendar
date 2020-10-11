import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "CommonUI",
                                targets: [.framework],
                                packages: [],
                                externalDependencies: [],
                                internalDependencies: [
                                      "DesignSystem",
                                      "Core"
                                    ],
                                resources: [.glob(pattern: "**/*.xib"),
                                            .glob(pattern: "Resources/**")],
                                withPublicResources: true)
