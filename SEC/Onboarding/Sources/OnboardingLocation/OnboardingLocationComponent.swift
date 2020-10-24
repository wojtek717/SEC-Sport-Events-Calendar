import Core
import NeedleFoundation
import UIKit
import Location
import EventsPanel

public protocol OnboardingLocationDependency: Dependency {
    var locationWorker: LocationWorkerProtocol { get }
}

public protocol OnboardingLocationRouting: RoutesDefinition {
    var eventsPanel: EventsPanelComponent { get }
}

public final class OnboardingLocationComponent: Component<OnboardingLocationDependency> {}

extension OnboardingLocationComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = OnboardingLocationViewController(nib: R.nib.onboardingLocationViewController)

        let presenter = OnboardingLocationPresenter(viewController: viewController)
        let interactor = OnboardingLocationInteractor(presenter: presenter, locationWorker: dependency.locationWorker)
        let router = OnboardingLocationRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension OnboardingLocationComponent: OnboardingLocationRouting {
    public var eventsPanel: EventsPanelComponent {
        EventsPanelComponent()
    }
}
