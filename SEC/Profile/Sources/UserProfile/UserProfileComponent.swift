import Core
import NeedleFoundation
import UIKit
import Authentication
import Networking

public protocol UserProfileDependency: Dependency {
    var authenticationWorker: AuthenticationWorkerProtocol { get }
    var networkingWorker: NetworkingWorkerProtocol { get }

}

public protocol UserProfileRouting: RoutesDefinition {}

public final class UserProfileComponent: Component<UserProfileDependency> {}

extension UserProfileComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = UserProfileViewController(nib: R.nib.userProfileViewController)

        let presenter = UserProfilePresenter(viewController: viewController)
        let interactor = UserProfileInteractor(
            presenter: presenter,
            authenticationWorker: dependency.authenticationWorker,
            networkingWorker: dependency.networkingWorker)
        let router = UserProfileRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension UserProfileComponent: UserProfileRouting {}
