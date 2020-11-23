import UIKit
import Authentication

typealias MainEventsListRouterType = MainEventsListRouterProtocol

protocol MainEventsListRouterProtocol {
    func navigateToLocalizationSelect()
    func navigateToSportTypeSelect(currentlySelected: [SportType])
    func navigateToAuthentication()
    func navigateToUserProfile()
    func navigateToEventDetails(eventId: String)
    func navigateToEventCreator()
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
    func navigateToEventCreator() {
        let eventCreatorViewController = routes.eventCreator.creatorFirstStep.viewController
        let navigationController = UINavigationController(rootViewController: eventCreatorViewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
    
    func navigateToEventDetails(eventId: String) {
        let eventDetailsViewController = routes.eventDetails(eventId: eventId).viewController
        let navigationController = UINavigationController(rootViewController: eventDetailsViewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
    
    func navigateToUserProfile() {
        let userProfileViewController = routes.profile.userProfile.viewController
        let navigationController = UINavigationController(rootViewController: userProfileViewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
    
    func navigateToAuthentication() {
        let enterPhoneNumberViewController = routes.authentication.enterPhoneNumber.viewController
        let navigationController = UINavigationController(rootViewController: enterPhoneNumberViewController)
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true)
    }
    
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
