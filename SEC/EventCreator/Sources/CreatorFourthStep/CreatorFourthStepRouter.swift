import UIKit

typealias CreatorFourthStepRouterType = CreatorFourthStepRouterProtocol

@objc protocol CreatorFourthStepRouterProtocol {
    func navigateToFifthStep()
}

final class CreatorFourthStepRouter {

    // MARK: - Public Properties

    private weak var viewController: CreatorFourthStepViewController?
    private let dataStore: CreatorFourthStepDataStore

    // MARK: - Private Properties

    private let routes: CreatorFourthStepRouting

    // MARK: - Initializers

    init(viewController: CreatorFourthStepViewController?,
         dataStore: CreatorFourthStepDataStore,
         routes: CreatorFourthStepRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension CreatorFourthStepRouter: CreatorFourthStepRouterProtocol {
    func navigateToFifthStep() {
        let fifthStepViewController = routes.fifthStep(eventEntity: dataStore.eventEntity).viewController
        viewController?.navigationController?.pushViewController(
            fifthStepViewController,
            animated: true)
    }
}