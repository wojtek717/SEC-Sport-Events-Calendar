import UIKit

typealias MainEventsListRouterType = MainEventsListRouterProtocol

protocol MainEventsListRouterProtocol {
    func navigateToLocalizationSelect()
    func navigateToSportTypeSelect(currentlySelected: [SportType])
}

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

extension MainEventsListRouter: MainEventsListRouterProtocol {
    func navigateToLocalizationSelect() {
        let localizationSelectViewController = routes.localizationSelect(delegate: viewController).viewController
        let navigationController = UINavigationController(rootViewController: localizationSelectViewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
    
    func navigateToSportTypeSelect(currentlySelected: [SportType]) {
        let sportTypeSelectViewController = routes.spotyTypeSelect(delegate: viewController,
                                                                   currentlySelected: currentlySelected).viewController
        let navigationController = UINavigationController(rootViewController: sportTypeSelectViewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
}
