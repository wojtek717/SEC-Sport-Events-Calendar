import Core
import NeedleFoundation
import UIKit
import Location
import Networking
import Authentication

public protocol EventDetailsDependency: Dependency {
    var locationWorker: LocationWorkerProtocol { get }
    var networkingWorker: NetworkingWorkerProtocol { get }
    var dateHelper: DateHelper { get }
    var authenticationWorker: AuthenticationWorkerProtocol { get }
}

public protocol EventDetailsRouting: RoutesDefinition {}

public final class EventDetailsComponent: Component<EventDetailsDependency>, RoutableComponent {
    
    private let eventId: String
    
    public init(parent: Scope, eventId: String) {
        self.eventId = eventId
        
        super.init(parent: parent)
    }

    public var viewController: UIViewController {
        let viewController = EventDetailsViewController(nib: R.nib.eventDetailsViewController)

        let presenter = EventDetailsPresenter(viewController: viewController,
                                              dateHelper: dependency.dateHelper)
        let interactor = EventDetailsInteractor(presenter: presenter,
                                                eventId: eventId,
                                                locationWorker: dependency.locationWorker,
                                                networkingWorker: dependency.networkingWorker,
                                                dateHelper: dependency.dateHelper,
                                                authenticationWorker: dependency.authenticationWorker)
        let router = EventDetailsRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension EventDetailsComponent: EventDetailsRouting {}
