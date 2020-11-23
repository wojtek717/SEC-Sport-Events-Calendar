import UIKit

protocol CreatorFirstStepPresenterLogic {}

final class CreatorFirstStepPresenter {

    // MARK: - Private Properties

    private weak var viewController: CreatorFirstStepViewControllerLogic?

    // MARK: - Initializers

    init(viewController: CreatorFirstStepViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension CreatorFirstStepPresenter: CreatorFirstStepPresenterLogic {}
