import UIKit

protocol SplashViewControllerLogic: AnyObject {}

final class SplashViewController: UIViewController {

    // MARK: - Public Properties

    var interactor: SplashInteractorLogic?
    var router: SplashRouterType?
}

extension SplashViewController: SplashViewControllerLogic {}
