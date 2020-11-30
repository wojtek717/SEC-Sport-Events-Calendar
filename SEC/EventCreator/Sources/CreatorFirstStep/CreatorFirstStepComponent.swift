import Core
import NeedleFoundation
import UIKit

public protocol CreatorFirstStepDependency: Dependency {
    var eventEntity: EventEntity { get }
}

public protocol CreatorFirstStepRouting: RoutesDefinition {
    func secondStep(eventEntity: EventEntity) -> CreatorSecondStepComponent
}

public final class CreatorFirstStepComponent: Component<CreatorFirstStepDependency> {}

extension CreatorFirstStepComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = CreatorFirstStepViewController(nib: R.nib.creatorFirstStepViewController)

        let presenter = CreatorFirstStepPresenter(viewController: viewController)
        let interactor = CreatorFirstStepInteractor(presenter: presenter, eventEntity: dependency.eventEntity)
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
