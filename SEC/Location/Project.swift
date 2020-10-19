import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "Location",
                                targets: [.framework],
                                packages: [],
                                externalDependencies: [],
                                internalDependencies: [
                                    "Core",
                                ],
                                resources: [],
                                withPublicResources: true)
