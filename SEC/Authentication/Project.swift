import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.framework(name: "Authentication",
                                targets: [.framework],
                                packages: [
                                    .package(url: "https://github.com/firebase/firebase-ios-sdk.git", from: "7.1.0"),
                                    .package(url: "https://github.com/marmelroy/PhoneNumberKit", from: "3.3.1")
                                ],
                                externalDependencies: [
                                    .package(product: "FirebaseAuth"),
                                    .package(product: "PhoneNumberKit")
                                ],
                                internalDependencies: [
                                    "Core",
                                    "DesignSystem",
                                    "CommonUI",
                                    "Networking",
                                ],
                                resources: [.glob(pattern: "**/*.xib")],
                                withPublicResources: false)
