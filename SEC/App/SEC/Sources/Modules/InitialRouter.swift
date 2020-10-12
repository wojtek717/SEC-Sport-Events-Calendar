import Core
import NeedleFoundation
import UIKit

protocol InitialRouterProtocol {
    func navigateToSplashScreen()
}

final class InitialRouter {
    // MARK: - Private Properties

    private let window: UIWindow?
    private let nextModule: UIViewController

    // MARK: - Initializers

    init(window: UIWindow?, nextModule: UIViewController) {
        self.window = window
        self.nextModule = nextModule
    }
}

extension InitialRouter: InitialRouterProtocol {
    func navigateToSplashScreen() {
        let navigationController = UINavigationController(rootViewController: nextModule)
        navigationController.setNavigationBarHidden(true, animated: false)
        window?.rootViewController = navigationController
    }
}
