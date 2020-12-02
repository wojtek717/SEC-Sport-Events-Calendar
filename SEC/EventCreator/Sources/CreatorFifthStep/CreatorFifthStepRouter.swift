import UIKit

typealias CreatorFifthStepRouterType = CreatorFifthStepRouterProtocol

@objc protocol CreatorFifthStepRouterProtocol {}

final class CreatorFifthStepRouter {

    // MARK: - Public Properties

    private weak var viewController: CreatorFifthStepViewController?
    private let dataStore: CreatorFifthStepDataStore

    // MARK: - Private Properties

    private let routes: CreatorFifthStepRouting

    // MARK: - Initializers

    init(viewController: CreatorFifthStepViewController?,
         dataStore: CreatorFifthStepDataStore,
         routes: CreatorFifthStepRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension CreatorFifthStepRouter: CreatorFifthStepRouterProtocol {}
