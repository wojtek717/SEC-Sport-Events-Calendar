import Core
import NeedleFoundation
import UIKit

public protocol MainEventsListDependency: Dependency {}

public protocol MainEventsListRouting: RoutesDefinition {}

public final class MainEventsListComponent: Component<MainEventsListDependency> {}

extension MainEventsListComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = MainEventsListViewController(nib: R.nib.mainEventsListViewController)

        let presenter = MainEventsListPresenter(viewController: viewController)
        let interactor = MainEventsListInteractor(presenter: presenter)
        let router = MainEventsListRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension MainEventsListComponent: MainEventsListRouting {}
