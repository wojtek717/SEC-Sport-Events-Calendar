import Core
import NeedleFoundation
import UIKit
import Location
import Networking
import Authentication

public protocol EventsPanelRouting: RoutesDefinition {
    var mainEventsList: MainEventsListComponent { get }
}

public final class EventsPanelComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
    
    var locationWorker: LocationWorkerProtocol {
        locationComponent.locationWorker
    }
    
    var networkingWorker: NetworkingWorkerProtocol {
        networkingComponent.networkingWorker
    }
    
    var dateHelper: DateHelper {
        DateHelper()
    }
    
    var authenticationWorker: AuthenticationWorkerProtocol {
        authenticationComponent.authenticationWorker
    }
 }

extension EventsPanelComponent: EventsPanelRouting {
    public var mainEventsList: MainEventsListComponent {
        MainEventsListComponent(parent: self)
    }
 }
