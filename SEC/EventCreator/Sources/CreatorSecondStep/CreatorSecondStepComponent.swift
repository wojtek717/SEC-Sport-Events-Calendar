import Core
import NeedleFoundation
import UIKit

public protocol CreatorSecondStepDependency: Dependency {
}

public protocol CreatorSecondStepRouting: RoutesDefinition {
    func thirdStep(eventEntity: EventEntity) -> CreatorThirdStepComponent
}

public final class CreatorSecondStepComponent: Component<CreatorSecondStepDependency>, RoutableComponent {

    var eventEntity: EventEntity
    
    public init(parent: Scope, eventEntity: EventEntity) {
        self.eventEntity = eventEntity
        
        super.init(parent: parent)
    }
    
    public var viewController: UIViewController {
        let viewController = CreatorSecondStepViewController(nib: R.nib.creatorSecondStepViewController)

        let presenter = CreatorSecondStepPresenter(viewController: viewController)
        let interactor = CreatorSecondStepInteractor(presenter: presenter, eventEntity: eventEntity)
        let router = CreatorSecondStepRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension CreatorSecondStepComponent: CreatorSecondStepRouting {
    public func thirdStep(eventEntity: EventEntity) -> CreatorThirdStepComponent {
        CreatorThirdStepComponent(parent: self, eventEntity: eventEntity)
    }
}
