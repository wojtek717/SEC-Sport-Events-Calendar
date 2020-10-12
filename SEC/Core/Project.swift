import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "Core",
                                targets: [.framework],
                                packages: [],
                                externalDependencies: [],
                                internalDependencies: [
                                    "DesignSystem",
                                ],
                                resources: [.glob(pattern: "Resources/**")],
                                withPublicResources: true)
