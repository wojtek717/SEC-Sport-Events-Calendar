import Core
import NeedleFoundation
import UIKit

public protocol CreatorThirdStepDependency: Dependency {}

public protocol CreatorThirdStepRouting: RoutesDefinition {
    func fourthStep(eventEntity: EventEntity) -> CreatorFourthStepComponent
}

public final class CreatorThirdStepComponent: Component<CreatorThirdStepDependency>, RoutableComponent {
    
    var eventEntity: EventEntity
    
    public init(parent: Scope, eventEntity: EventEntity) {
        self.eventEntity = eventEntity
        
        super.init(parent: parent)
    }
    
    
    public var viewController: UIViewController {
        let viewController = CreatorThirdStepViewController(nib: R.nib.creatorThirdStepViewController)

        let presenter = CreatorThirdStepPresenter(viewController: viewController)
        let interactor = CreatorThirdStepInteractor(presenter: presenter, eventEntity: eventEntity)
        let router = CreatorThirdStepRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension CreatorThirdStepComponent: CreatorThirdStepRouting {
    public func fourthStep(eventEntity: EventEntity) -> CreatorFourthStepComponent {
        CreatorFourthStepComponent(parent: self, eventEntity: eventEntity)
    }
    

}
