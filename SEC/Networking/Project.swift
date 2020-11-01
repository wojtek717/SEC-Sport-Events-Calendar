import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "Networking",
                                targets: [.framework],
                                packages: [
                                    .package(url: "https://github.com/apollographql/apollo-ios.git", .upToNextMajor(from: "0.36.0")),
                                ],
                                externalDependencies: [
                                    .package(product: "Apollo"),
                                ],
                                internalDependencies: ["Core"],
                                resources: [
                                    "schema.json",
                                    "API.swift",
                                    "Queries/*"
                                ])

