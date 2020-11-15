import UIKit

typealias EnterPhoneNumberRouterType = EnterPhoneNumberRouterProtocol

@objc protocol EnterPhoneNumberRouterProtocol {
    func navigateToSmsConfirmation()
    func dismiss()
}

final class EnterPhoneNumberRouter {

    // MARK: - Public Properties

    private weak var viewController: EnterPhoneNumberViewController?
    private let dataStore: EnterPhoneNumberDataStore

    // MARK: - Private Properties

    private let routes: EnterPhoneNumberRouting

    // MARK: - Initializers

    init(viewController: EnterPhoneNumberViewController?,
         dataStore: EnterPhoneNumberDataStore,
         routes: EnterPhoneNumberRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension EnterPhoneNumberRouter: EnterPhoneNumberRouterProtocol {
    func navigateToSmsConfirmation() {
        let smsConfirmationViewController = routes.smsConfirmation.viewController
        viewController?.navigationController?.pushViewController(smsConfirmationViewController, animated: true)
    }
    
    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
