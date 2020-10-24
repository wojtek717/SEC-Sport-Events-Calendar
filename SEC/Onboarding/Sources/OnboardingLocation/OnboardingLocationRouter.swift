import UIKit

typealias OnboardingLocationRouterType = OnboardingLocationRouterProtocol

@objc protocol OnboardingLocationRouterProtocol {
    func navigateToMainEventsList()
}

final class OnboardingLocationRouter {

    // MARK: - Public Properties

    private weak var viewController: OnboardingLocationViewController?
    private let dataStore: OnboardingLocationDataStore

    // MARK: - Private Properties

    private let routes: OnboardingLocationRouting

    // MARK: - Initializers

    init(viewController: OnboardingLocationViewController?,
         dataStore: OnboardingLocationDataStore,
         routes: OnboardingLocationRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension OnboardingLocationRouter: OnboardingLocationRouterProtocol {
    func navigateToMainEventsList() {
        let mainEventsListViewController = routes.eventsPanel.mainEventsList.viewController
        let navigationController = UINavigationController(rootViewController: mainEventsListViewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.modalTransitionStyle = .crossDissolve
        self.viewController?.present(navigationController, animated: true)
    }
}
