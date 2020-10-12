import UIKit

protocol SplashPresenterLogic {}

final class SplashPresenter {

    // MARK: - Private Properties

    private weak var viewController: SplashViewControllerLogic?

    // MARK: - Initializers

    init(viewController: SplashViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension SplashPresenter: SplashPresenterLogic {}
