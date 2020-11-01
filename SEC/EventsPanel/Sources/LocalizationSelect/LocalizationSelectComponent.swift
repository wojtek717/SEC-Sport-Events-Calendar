import Core
import NeedleFoundation
import UIKit
import Location

public protocol LocalizationSelectDependency: Dependency {
    var locationWorker: LocationWorkerProtocol { get }
}

public protocol LocalizationSelectRouting: RoutesDefinition {}

public final class LocalizationSelectComponent: Component<LocalizationSelectDependency> {}

extension LocalizationSelectComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = LocalizationSelectViewController(nib: R.nib.localizationSelectViewController)

        let presenter = LocalizationSelectPresenter(viewController: viewController)
        let interactor = LocalizationSelectInteractor(presenter: presenter, locationWorker: dependency.locationWorker)
        let router = LocalizationSelectRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension LocalizationSelectComponent: LocalizationSelectRouting {}
