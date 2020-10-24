import Core
import NeedleFoundation
import UIKit

public protocol EventsPanelRouting: RoutesDefinition {
    var mainEventsList: MainEventsListComponent { get }
}

public final class EventsPanelComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
 }

extension EventsPanelComponent: EventsPanelRouting {
    public var mainEventsList: MainEventsListComponent {
        MainEventsListComponent(parent: self)
    }
 }
