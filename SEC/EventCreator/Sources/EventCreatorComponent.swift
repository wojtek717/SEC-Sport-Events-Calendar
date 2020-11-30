import Core
import NeedleFoundation
import UIKit
import Location

public protocol EventCreatorRouting: RoutesDefinition {
    var creatorFirstStep: CreatorFirstStepComponent { get }
}

public final class EventCreatorComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
    
    var locationWorker: LocationWorkerProtocol {
        locationComponent.locationWorker
    }
    
    var eventEntity: EventEntity {
        shared { EventEntity() }
    }
 }

extension EventCreatorComponent: EventCreatorRouting {
    public var creatorFirstStep: CreatorFirstStepComponent {
        CreatorFirstStepComponent(parent: self)
    }
}
