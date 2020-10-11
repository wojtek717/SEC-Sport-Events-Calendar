import Core
import NeedleFoundation
import UIKit

public protocol SplashRouting: RoutesDefinition { }

public final class SplashComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
 }

 extension SplashComponent: SplashRouting {}
