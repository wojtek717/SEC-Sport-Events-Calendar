import UIKit

protocol EnterPhoneNumberPresenterLogic {
    func presentSmsConfirmation()
}

final class EnterPhoneNumberPresenter {

    // MARK: - Private Properties

    private weak var viewController: EnterPhoneNumberViewControllerLogic?

    // MARK: - Initializers

    init(viewController: EnterPhoneNumberViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension EnterPhoneNumberPresenter: EnterPhoneNumberPresenterLogic {
    func presentSmsConfirmation() {
        viewController?.navigateToSmsConfirmation()
    }
}
