import Core
import NeedleFoundation
import UIKit

public protocol EnterPhoneNumberDependency: Dependency {
    var authenticationWorker: AuthenticationWorkerProtocol { get }
}

public protocol EnterPhoneNumberRouting: RoutesDefinition {
    var smsConfirmation: SmsConfirmationComponent { get }
}

public final class EnterPhoneNumberComponent: Component<EnterPhoneNumberDependency> {}

extension EnterPhoneNumberComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = EnterPhoneNumberViewController(nib: R.nib.enterPhoneNumberViewController)

        let presenter = EnterPhoneNumberPresenter(viewController: viewController)
        let interactor = EnterPhoneNumberInteractor(presenter: presenter, authenticationWorker: dependency.authenticationWorker)
        let router = EnterPhoneNumberRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension EnterPhoneNumberComponent: EnterPhoneNumberRouting {
    public var smsConfirmation: SmsConfirmationComponent {
        SmsConfirmationComponent(parent: self)
    }
}
