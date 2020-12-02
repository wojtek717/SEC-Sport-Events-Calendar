import Core
import NeedleFoundation
import UIKit

public protocol CreatorFifthStepDependency: Dependency {}

public protocol CreatorFifthStepRouting: RoutesDefinition {}

public final class CreatorFifthStepComponent: Component<CreatorFifthStepDependency>, RoutableComponent {

    var eventEntity: EventEntity
    
    public init(parent: Scope, eventEntity: EventEntity) {
        self.eventEntity = eventEntity
        
        super.init(parent: parent)
    }

    public var viewController: UIViewController {
        let viewController = CreatorFifthStepViewController(nib: R.nib.creatorFifthStepViewController)

        let presenter = CreatorFifthStepPresenter(viewController: viewController)
        let interactor = CreatorFifthStepInteractor(presenter: presenter, eventEntity: eventEntity)
        let router = CreatorFifthStepRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension CreatorFifthStepComponent: CreatorFifthStepRouting {}
