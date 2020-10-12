import Core
import NeedleFoundation
import UIKit

public protocol CommonUIRouting: RoutesDefinition { }

public final class CommonUIComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
 }

 extension CommonUIComponent: CommonUIRouting {}
