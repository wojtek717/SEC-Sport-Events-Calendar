import UIKit

typealias MainEventsListRouterType = MainEventsListRouterProtocol

@objc protocol MainEventsListRouterProtocol {}

final class MainEventsListRouter {

    // MARK: - Public Properties

    private weak var viewController: MainEventsListViewController?
    private let dataStore: MainEventsListDataStore

    // MARK: - Private Properties

    private let routes: MainEventsListRouting

    // MARK: - Initializers

    init(viewController: MainEventsListViewController?,
         dataStore: MainEventsListDataStore,
         routes: MainEventsListRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension MainEventsListRouter: MainEventsListRouterProtocol {}
