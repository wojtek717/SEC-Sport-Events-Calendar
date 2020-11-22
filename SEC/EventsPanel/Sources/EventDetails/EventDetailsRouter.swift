import UIKit

typealias EventDetailsRouterType = EventDetailsRouterProtocol

@objc protocol EventDetailsRouterProtocol {
    func dismiss()
}

final class EventDetailsRouter {

    // MARK: - Public Properties

    private weak var viewController: EventDetailsViewController?
    private let dataStore: EventDetailsDataStore

    // MARK: - Private Properties

    private let routes: EventDetailsRouting

    // MARK: - Initializers

    init(viewController: EventDetailsViewController?,
         dataStore: EventDetailsDataStore,
         routes: EventDetailsRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension EventDetailsRouter: EventDetailsRouterProtocol {
    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
