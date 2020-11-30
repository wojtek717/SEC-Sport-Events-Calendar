import Core
import NeedleFoundation
import UIKit

public protocol CreatorFirstStepDependency: Dependency {}

public protocol CreatorFirstStepRouting: RoutesDefinition {
    func secondStep(eventEntity: EventEntity) -> CreatorSecondStepComponent
}

public final class CreatorFirstStepComponent: Component<CreatorFirstStepDependency>, RoutableComponent {
    
    var eventEntity: EventEntity
    
    public init(parent: Scope, eventEntity: EventEntity) {
        self.eventEntity = eventEntity
        
        super.init(parent: parent)
    }
    
    public var viewController: UIViewController {
        let viewController = CreatorFirstStepViewController(nib: R.nib.creatorFirstStepViewController)

        let presenter = CreatorFirstStepPresenter(viewController: viewController)
        let interactor = CreatorFirstStepInteractor(presenter: presenter, eventEntity: eventEntity)
        let router = CreatorFirstStepRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension CreatorFirstStepComponent: CreatorFirstStepRouting {
    public func secondStep(eventEntity: EventEntity) -> CreatorSecondStepComponent {
        CreatorSecondStepComponent(parent: self, eventEntity: eventEntity)
    }
}
