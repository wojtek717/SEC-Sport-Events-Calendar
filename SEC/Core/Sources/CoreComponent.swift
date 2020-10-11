import NeedleFoundation
import UIKit

public protocol CoreRouting: RoutesDefinition { }

public final class CoreComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
 }

 extension CoreComponent: CoreRouting {}
