import UIKit

typealias SportTypeSelectRouterType = SportTypeSelectRouterProtocol

protocol SportTypeSelectRouterProtocol {
    func dismiss()
}

final class SportTypeSelectRouter {
    
    // MARK: - Private Properties
    
    private weak var viewController: SportTypeSelectViewController?
    private let dataStore: SportTypeSelectDataStore
    
    private let routes: SportTypeSelectRouting
    private weak var delegate: MainEventsListSelectionDelegate?
    
    // MARK: - Initializers
    
    init(viewController: SportTypeSelectViewController?,
         dataStore: SportTypeSelectDataStore,
         routes: SportTypeSelectRouting,
         delegate: MainEventsListSelectionDelegate?) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
        self.delegate = delegate
    }
}

extension SportTypeSelectRouter: SportTypeSelectRouterProtocol {
    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
