import UIKit

protocol CreatorSecondStepPresenterLogic {}

final class CreatorSecondStepPresenter {

    // MARK: - Private Properties

    private weak var viewController: CreatorSecondStepViewControllerLogic?

    // MARK: - Initializers

    init(viewController: CreatorSecondStepViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension CreatorSecondStepPresenter: CreatorSecondStepPresenterLogic {}
