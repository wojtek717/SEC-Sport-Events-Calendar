import Core
import NeedleFoundation
import UIKit

public protocol CreatorSecondStepDependency: Dependency {}

public protocol CreatorSecondStepRouting: RoutesDefinition {
    var thirdStep: CreatorThirdStepComponent { get }
}

public final class CreatorSecondStepComponent: Component<CreatorSecondStepDependency> {}

extension CreatorSecondStepComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = CreatorSecondStepViewController(nib: R.nib.creatorSecondStepViewController)

        let presenter = CreatorSecondStepPresenter(viewController: viewController)
        let interactor = CreatorSecondStepInteractor(presenter: presenter)
        let router = CreatorSecondStepRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension CreatorSecondStepComponent: CreatorSecondStepRouting {
    public var thirdStep: CreatorThirdStepComponent {
        CreatorThirdStepComponent(parent: self)
    }
}
