import Core
import NeedleFoundation
import UIKit
import Location
import CommonUI

public protocol EventCreatorRouting: RoutesDefinition {
    func creatorFirstStep(sportType: SportType) -> CreatorFirstStepComponent
    func creatorSportType(delegate: MainEventsListCreatorDelegate?) -> CreatorSportTypeComponent
}

public final class EventCreatorComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()
        
        super.init()
    }
    
    var locationWorker: LocationWorkerProtocol {
        locationComponent.locationWorker
    }
}

extension EventCreatorComponent: EventCreatorRouting {
    public func creatorFirstStep(sportType: SportType) -> CreatorFirstStepComponent {
        let eventEntity = EventEntity(sportType: sportType)
        return CreatorFirstStepComponent(parent: self, eventEntity: eventEntity)
    }
    
    public func creatorSportType(delegate: MainEventsListCreatorDelegate?) -> CreatorSportTypeComponent {
        CreatorSportTypeComponent(parent: self, delegate: delegate)
    }
}
