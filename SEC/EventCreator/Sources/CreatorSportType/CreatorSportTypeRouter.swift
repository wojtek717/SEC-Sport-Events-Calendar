import UIKit

typealias CreatorSportTypeRouterType = CreatorSportTypeRouterProtocol

@objc protocol CreatorSportTypeRouterProtocol {
    func dismiss()
}

final class CreatorSportTypeRouter {

    // MARK: - Public Properties

    private weak var viewController: CreatorSportTypeViewController?
    private let dataStore: CreatorSportTypeDataStore

    // MARK: - Private Properties

    private let routes: CreatorSportTypeRouting

    // MARK: - Initializers

    init(viewController: CreatorSportTypeViewController?,
         dataStore: CreatorSportTypeDataStore,
         routes: CreatorSportTypeRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension CreatorSportTypeRouter: CreatorSportTypeRouterProtocol {
    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
