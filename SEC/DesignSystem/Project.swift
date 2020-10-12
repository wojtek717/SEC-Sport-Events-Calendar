import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "DesignSystem",
                                targets: [.framework],
                                resources: [.glob(pattern: "**/*.xib"),
                                            .glob(pattern: "Resources/**")],
                                withPublicResources: true)
