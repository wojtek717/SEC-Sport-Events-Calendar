import UIKit

protocol SmsConfirmationPresenterLogic {
    func presentEventsList()
}

final class SmsConfirmationPresenter {

    // MARK: - Private Properties

    private weak var viewController: SmsConfirmationViewControllerLogic?

    // MARK: - Initializers

    init(viewController: SmsConfirmationViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension SmsConfirmationPresenter: SmsConfirmationPresenterLogic {
    func presentEventsList() {
        viewController?.presentEventsList()
    }
}
