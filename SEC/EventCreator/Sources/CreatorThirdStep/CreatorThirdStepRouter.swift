import UIKit

typealias CreatorThirdStepRouterType = CreatorThirdStepRouterProtocol

@objc protocol CreatorThirdStepRouterProtocol {
    func navigateToFourthStep()
}

final class CreatorThirdStepRouter {

    // MARK: - Public Properties

    private weak var viewController: CreatorThirdStepViewController?
    private let dataStore: CreatorThirdStepDataStore

    // MARK: - Private Properties

    private let routes: CreatorThirdStepRouting

    // MARK: - Initializers

    init(viewController: CreatorThirdStepViewController?,
         dataStore: CreatorThirdStepDataStore,
         routes: CreatorThirdStepRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension CreatorThirdStepRouter: CreatorThirdStepRouterProtocol {
    func navigateToFourthStep() {
        let fourthStepViewController = routes.fourthStep(eventEntity: dataStore.eventEntity).viewController
        viewController?.navigationController?.pushViewController(
            fourthStepViewController,
            animated: true)
    }
}
