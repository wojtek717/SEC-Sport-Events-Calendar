import Core
import NeedleFoundation
import UIKit
import Networking
import Location
import Authentication
import Profile
import EventCreator

public protocol MainEventsListDependency: Dependency {
    var locationWorker: LocationWorkerProtocol { get }
    var networkingWorker: NetworkingWorkerProtocol { get }
    var dateHelper: DateHelper { get }
    var authenticationWorker: AuthenticationWorkerProtocol { get }
}

public protocol MainEventsListRouting: RoutesDefinition {
    func localizationSelect(delegate: MainEventsListSelectionDelegate?) -> LocalizationSelectComponent
    func spotyTypeSelect(delegate: MainEventsListSelectionDelegate?,
                         currentlySelected: [SportType]) -> SportTypeSelectComponent
    var authentication: AuthenticationComponent { get }
    var profile: ProfileComponent { get }
    func eventDetails(eventId: String) -> EventDetailsComponent
    var eventCreator: EventCreatorComponent { get }
}

public final class MainEventsListComponent: Component<MainEventsListDependency> {}

extension MainEventsListComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = MainEventsListViewController(nib: R.nib.mainEventsListViewController)

        let presenter = MainEventsListPresenter(viewController: viewController)
        let interactor = MainEventsListInteractor(presenter: presenter,
                                                  locationWorker: dependency.locationWorker,
                                                  networkingWorker: dependency.networkingWorker,
                                                  dateHelper: dependency.dateHelper,
                                                  authenticationWorker: dependency.authenticationWorker)
        let router = MainEventsListRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension MainEventsListComponent: MainEventsListRouting {
    public var eventCreator: EventCreatorComponent {
        EventCreatorComponent()
    }
    
    public func eventDetails(eventId: String) -> EventDetailsComponent {
        EventDetailsComponent(parent: self, eventId: eventId)
    }
    
    public var profile: ProfileComponent {
        ProfileComponent()
    }
    
    public var authentication: AuthenticationComponent {
        authenticationComponent
    }
    
    public func localizationSelect(delegate: MainEventsListSelectionDelegate?) -> LocalizationSelectComponent {
        LocalizationSelectComponent(parent: self, delegate: delegate)
    }
    
    public func spotyTypeSelect(delegate: MainEventsListSelectionDelegate?,
                                currentlySelected: [SportType]) -> SportTypeSelectComponent {
        SportTypeSelectComponent(parent: self, delegate: delegate, currentlySelected: currentlySelected)
    }
}
