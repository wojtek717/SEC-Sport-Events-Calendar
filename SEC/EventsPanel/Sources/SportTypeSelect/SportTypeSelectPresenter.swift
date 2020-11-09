import UIKit

protocol SportTypeSelectPresenterLogic {}

final class SportTypeSelectPresenter {

    // MARK: - Private Properties

    private weak var viewController: SportTypeSelectViewControllerLogic?

    // MARK: - Initializers

    init(viewController: SportTypeSelectViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension SportTypeSelectPresenter: SportTypeSelectPresenterLogic {}
