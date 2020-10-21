import UIKit

protocol MainEventsListPresenterLogic {}

final class MainEventsListPresenter {

    // MARK: - Private Properties

    private weak var viewController: MainEventsListViewControllerLogic?

    // MARK: - Initializers

    init(viewController: MainEventsListViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension MainEventsListPresenter: MainEventsListPresenterLogic {}
