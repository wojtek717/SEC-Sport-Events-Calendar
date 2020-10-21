import UIKit

protocol OnboardingLocationPresenterLogic {
    func presentMainEventsList()
}

final class OnboardingLocationPresenter {

    // MARK: - Private Properties

    private weak var viewController: OnboardingLocationViewControllerLogic?

    // MARK: - Initializers

    init(viewController: OnboardingLocationViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension OnboardingLocationPresenter: OnboardingLocationPresenterLogic {
    func presentMainEventsList() {
        viewController?.presentMainEventsList()
    }
}
