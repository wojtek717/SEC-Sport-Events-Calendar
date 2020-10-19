import UIKit

protocol OnboardingLocationPresenterLogic {}

final class OnboardingLocationPresenter {

    // MARK: - Private Properties

    private weak var viewController: OnboardingLocationViewControllerLogic?

    // MARK: - Initializers

    init(viewController: OnboardingLocationViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension OnboardingLocationPresenter: OnboardingLocationPresenterLogic {}
