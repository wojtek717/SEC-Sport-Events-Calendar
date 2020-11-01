import Core
import NeedleFoundation
import UIKit
import Networking

public protocol EventsPanelRouting: RoutesDefinition {
    var mainEventsList: MainEventsListComponent { get }
}

public final class EventsPanelComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
    
    var networkingWorker: NetworkingWorkerProtocol {
        networkingComponent.networkingWorker
    }
    
    var dateHelper: DateHelper {
        DateHelper()
    }
 }

extension EventsPanelComponent: EventsPanelRouting {
    public var mainEventsList: MainEventsListComponent {
        MainEventsListComponent(parent: self)
    }
 }
