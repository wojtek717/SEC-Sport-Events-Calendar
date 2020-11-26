import UIKit

typealias CreatorSecondStepRouterType = CreatorSecondStepRouterProtocol

@objc protocol CreatorSecondStepRouterProtocol {
    func navigateToThirdStep()
}

final class CreatorSecondStepRouter {

    // MARK: - Public Properties

    private weak var viewController: CreatorSecondStepViewController?
    private let dataStore: CreatorSecondStepDataStore

    // MARK: - Private Properties

    private let routes: CreatorSecondStepRouting

    // MARK: - Initializers

    init(viewController: CreatorSecondStepViewController?,
         dataStore: CreatorSecondStepDataStore,
         routes: CreatorSecondStepRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension CreatorSecondStepRouter: CreatorSecondStepRouterProtocol {
    func navigateToThirdStep() {
        let thirdStepViewController = routes.thirdStep.viewController
        viewController?.navigationController?.pushViewController(
            thirdStepViewController,
            animated: true)
    }
}
