import Core
import NeedleFoundation
import UIKit

public protocol EventCreatorRouting: RoutesDefinition {
    var creatorFirstStep: CreatorFirstStepComponent { get }
}

public final class EventCreatorComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
 }

extension EventCreatorComponent: EventCreatorRouting {
    public var creatorFirstStep: CreatorFirstStepComponent {
        CreatorFirstStepComponent(parent: self)
    }
}
