import Core
import NeedleFoundation
import UIKit

public protocol OnboardingRouting: RoutesDefinition {
    var onboardingLocation: OnboardingLocationComponent { get }
}

public final class OnboardingComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
 }

extension OnboardingComponent: OnboardingRouting {
    public var onboardingLocation: OnboardingLocationComponent {
        OnboardingLocationComponent(parent: self)
    }
}
