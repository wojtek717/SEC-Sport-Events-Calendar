import UIKit
import Core
import Networking

protocol MainEventsListPresenterLogic {
    func presentEvents(events: [MainEventsListRow])
}

final class MainEventsListPresenter {

    // MARK: - Private Properties

    private weak var viewController: MainEventsListViewControllerLogic?

    // MARK: - Initializers

    init(viewController: MainEventsListViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension MainEventsListPresenter: MainEventsListPresenterLogic {
    func presentEvents(events: [MainEventsListRow]) {
        viewController?.presentEvents(events: events)
    }
}
