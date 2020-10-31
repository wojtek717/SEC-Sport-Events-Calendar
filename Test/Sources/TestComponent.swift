import Core
import NeedleFoundation
import UIKit

public protocol TestRouting: RoutesDefinition { }

public final class TestComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
 }

 extension TestComponent: TestRouting {}
