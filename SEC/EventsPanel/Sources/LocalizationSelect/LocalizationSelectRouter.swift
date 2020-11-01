import UIKit

typealias LocalizationSelectRouterType = LocalizationSelectRouterProtocol

@objc protocol LocalizationSelectRouterProtocol {
    func dismiss()
}

final class LocalizationSelectRouter {

    // MARK: - Public Properties

    private weak var viewController: LocalizationSelectViewController?
    private let dataStore: LocalizationSelectDataStore

    // MARK: - Private Properties

    private let routes: LocalizationSelectRouting

    // MARK: - Initializers

    init(viewController: LocalizationSelectViewController?,
         dataStore: LocalizationSelectDataStore,
         routes: LocalizationSelectRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension LocalizationSelectRouter: LocalizationSelectRouterProtocol {
    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
