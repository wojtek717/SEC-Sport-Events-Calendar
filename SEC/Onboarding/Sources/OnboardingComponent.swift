import Core
import NeedleFoundation
import UIKit
import Location

public protocol OnboardingRouting: RoutesDefinition {
    var onboardingLocation: OnboardingLocationComponent { get }
}

public final class OnboardingComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
    
    var locationWorker: LocationWorkerProtocol {
        locationComponent.locationWorker
    }
 }

extension OnboardingComponent: OnboardingRouting {
    public var onboardingLocation: OnboardingLocationComponent {
        OnboardingLocationComponent(parent: self)
    }
}
