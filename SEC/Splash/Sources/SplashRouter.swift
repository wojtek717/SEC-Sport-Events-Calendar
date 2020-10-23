import UIKit
import CommonUI
import Location

typealias SplashRouterType = SplashRouterProtocol

@objc protocol SplashRouterProtocol {
    func navigateToNextModule()
}

final class SplashRouter {

    // MARK: - Private Properties

    private weak var viewController: SplashViewController?
    private let dataStore: SplashDataStore

    private let routes: SplashRouting
    private let window: UIWindow?
    private let locationWorker: LocationWorkerProtocol

    // MARK: - Initializers

    init(viewController: SplashViewController?,
         dataStore: SplashDataStore,
         routes: SplashRouting,
         window: UIWindow?,
         locationWorker: LocationWorkerProtocol) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
        self.window = window
        self.locationWorker = locationWorker
    }
}

extension SplashRouter: SplashRouterProtocol {
    func navigateToNextModule() {
        let rootViewController: UIViewController
        let navigationController: UINavigationController
        
        if locationWorker.authorizationStatus == .notDetermined {
            rootViewController = routes.onboarding.onboardingLocation.viewController
            navigationController = UINavigationController(rootViewController: rootViewController)
        } else {
            rootViewController = routes.eventsPanel.mainEventsList.viewController
            navigationController = UINavigationController(rootViewController: rootViewController)
        }
        
        window?.pushToViewController(newRootController: navigationController)
    }
}
