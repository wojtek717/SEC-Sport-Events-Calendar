import Core
import NeedleFoundation
import UIKit

public protocol LocationRouting: RoutesDefinition { }

public let locationComponent = LocationComponent()

public final class LocationComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()
        
        super.init()
    }
    
    public var locationWorker: LocationWorkerProtocol {
        shared { LocationWorker() }
    }
}

extension LocationComponent: LocationRouting {}
