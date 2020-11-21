import UIKit

typealias UserProfileRouterType = UserProfileRouterProtocol

@objc protocol UserProfileRouterProtocol {
    func dismiss()
}

final class UserProfileRouter {

    // MARK: - Public Properties

    private weak var viewController: UserProfileViewController?
    private let dataStore: UserProfileDataStore

    // MARK: - Private Properties

    private let routes: UserProfileRouting

    // MARK: - Initializers

    init(viewController: UserProfileViewController?,
         dataStore: UserProfileDataStore,
         routes: UserProfileRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension UserProfileRouter: UserProfileRouterProtocol {
    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
