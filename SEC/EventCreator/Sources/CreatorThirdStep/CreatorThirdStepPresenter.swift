import UIKit

protocol CreatorThirdStepPresenterLogic {}

final class CreatorThirdStepPresenter {

    // MARK: - Private Properties

    private weak var viewController: CreatorThirdStepViewControllerLogic?

    // MARK: - Initializers

    init(viewController: CreatorThirdStepViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension CreatorThirdStepPresenter: CreatorThirdStepPresenterLogic {}
