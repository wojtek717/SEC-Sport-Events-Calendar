import UIKit

protocol CreatorSportTypePresenterLogic {}

final class CreatorSportTypePresenter {

    // MARK: - Private Properties

    private weak var viewController: CreatorSportTypeViewControllerLogic?

    // MARK: - Initializers

    init(viewController: CreatorSportTypeViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension CreatorSportTypePresenter: CreatorSportTypePresenterLogic {}
