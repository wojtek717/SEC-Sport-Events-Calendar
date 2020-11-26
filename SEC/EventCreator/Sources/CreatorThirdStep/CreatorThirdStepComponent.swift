import Core
import NeedleFoundation
import UIKit

public protocol CreatorThirdStepDependency: Dependency {}

public protocol CreatorThirdStepRouting: RoutesDefinition {}

public final class CreatorThirdStepComponent: Component<CreatorThirdStepDependency> {}

extension CreatorThirdStepComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = CreatorThirdStepViewController(nib: R.nib.creatorThirdStepViewController)

        let presenter = CreatorThirdStepPresenter(viewController: viewController)
        let interactor = CreatorThirdStepInteractor(presenter: presenter)
        let router = CreatorThirdStepRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension CreatorThirdStepComponent: CreatorThirdStepRouting {}
