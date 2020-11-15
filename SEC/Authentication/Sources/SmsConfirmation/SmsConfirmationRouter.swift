import UIKit

typealias SmsConfirmationRouterType = SmsConfirmationRouterProtocol

@objc protocol SmsConfirmationRouterProtocol {
    func dismiss()
}

final class SmsConfirmationRouter {
    
    // MARK: - Public Properties
    
    private weak var viewController: SmsConfirmationViewController?
    private let dataStore: SmsConfirmationDataStore
    
    // MARK: - Private Properties
    
    private let routes: SmsConfirmationRouting
    
    // MARK: - Initializers
    
    init(viewController: SmsConfirmationViewController?,
         dataStore: SmsConfirmationDataStore,
         routes: SmsConfirmationRouting) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
    }
}

extension SmsConfirmationRouter: SmsConfirmationRouterProtocol {
    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
