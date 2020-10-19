import UIKit

typealias OnboardingLocationRouterType = OnboardingLocationRouterProtocol

@objc protocol OnboardingLocationRouterProtocol {}

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

extension OnboardingLocationRouter: OnboardingLocationRouterProtocol {}
