import UIKit

typealias SplashRouterType = SplashRouterProtocol

@objc protocol SplashRouterProtocol {
    func navigateToNextModule()
}

final class SplashRouter {

    // MARK: - Public Properties

    private weak var viewController: SplashViewController?
    private let dataStore: SplashDataStore

    // MARK: - Private Properties

    private let routes: SplashRouting
    private let window: UIWindow?

    // MARK: - Initializers

    init(viewController: SplashViewController?,
         dataStore: SplashDataStore,
         routes: SplashRouting,
         window: UIWindow?) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
        self.window = window
    }
}

extension SplashRouter: SplashRouterProtocol {
    func navigateToNextModule() {
        
        let rootViewController: UIViewController
        

        //window?.pushToViewController(newRootController: rootViewController)
    }

}
