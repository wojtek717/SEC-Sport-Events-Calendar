import UIKit

typealias CreatorFirstStepRouterType = CreatorFirstStepRouterProtocol

@objc protocol CreatorFirstStepRouterProtocol {
    func dismiss()
}

final class CreatorFirstStepRouter {

    // MARK: - Public Properties

    private weak var viewController: CreatorFirstStepViewController?
    private let dataStore: CreatorFirstStepDataStore

    // MARK: - Private Properties

    private let routes: CreatorFirstStepRouting

    // MARK: - Initializers

    init(viewController: CreatorFirstStepViewController?,
         dataStore: CreatorFirstStepDataStore,
         routes: CreatorFirstStepRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension CreatorFirstStepRouter: CreatorFirstStepRouterProtocol {
    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
