import Core
import NeedleFoundation
import UIKit
import Apollo

public protocol NetworkingRouting: RoutesDefinition { }

// This is to ensure only one instance of networing component across the apps.
public let networkingComponent = NetworkingComponent()

public final class NetworkingComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
    
    public var networkingWorker: NetworkingWorkerProtocol {
        shared { NetworkingWorker() }
    }
 }

 extension NetworkingComponent: NetworkingRouting {}
