import Core
import NeedleFoundation
import UIKit
import Networking

public protocol SmsConfirmationDependency: Dependency {
    var authenticationWorker: AuthenticationWorkerProtocol { get }
    var networkingWorker: NetworkingWorkerProtocol { get }
}

public protocol SmsConfirmationRouting: RoutesDefinition {}

public final class SmsConfirmationComponent: Component<SmsConfirmationDependency> {}

extension SmsConfirmationComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = SmsConfirmationViewController(nib: R.nib.smsConfirmationViewController)

        let presenter = SmsConfirmationPresenter(viewController: viewController)
        let interactor = SmsConfirmationInteractor(presenter: presenter,
                                                   authenticationWorker: dependency.authenticationWorker,
                                                   networkingWorker: dependency.networkingWorker)
        let router = SmsConfirmationRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension SmsConfirmationComponent: SmsConfirmationRouting {}
