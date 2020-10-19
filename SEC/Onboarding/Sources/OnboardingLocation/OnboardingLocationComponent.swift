import Core
import NeedleFoundation
import UIKit

public protocol OnboardingLocationDependency: Dependency {}

public protocol OnboardingLocationRouting: RoutesDefinition {}

public final class OnboardingLocationComponent: Component<OnboardingLocationDependency> {}

extension OnboardingLocationComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = OnboardingLocationViewController(nib: R.nib.onboardingLocationViewController)

        let presenter = OnboardingLocationPresenter(viewController: viewController)
        let interactor = OnboardingLocationInteractor(presenter: presenter)
        let router = OnboardingLocationRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension OnboardingLocationComponent: OnboardingLocationRouting {}
