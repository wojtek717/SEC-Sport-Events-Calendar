import UIKit

typealias MainEventsListRouterType = MainEventsListRouterProtocol

@objc protocol MainEventsListRouterProtocol {
    func navigateToLocalizationSelect()
}

final class MainEventsListRouter {

    // MARK: - Public Properties

    private weak var viewController: MainEventsListViewController?
    private let dataStore: MainEventsListDataStore

    // MARK: - Private Properties

    private let routes: MainEventsListRouting

    // MARK: - Initializers

    init(viewController: MainEventsListViewController?,
         dataStore: MainEventsListDataStore,
         routes: MainEventsListRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension MainEventsListRouter: MainEventsListRouterProtocol {
    func navigateToLocalizationSelect() {
        let localizationSelectViewController = routes.localizationSelect(delegate: viewController).viewController
        let navigationController = UINavigationController(rootViewController: localizationSelectViewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
}
