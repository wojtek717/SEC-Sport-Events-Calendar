import UIKit

protocol UserProfilePresenterLogic {
    func presentUserData(name: String?, surname: String?)
}

final class UserProfilePresenter {

    // MARK: - Private Properties

    private weak var viewController: UserProfileViewControllerLogic?

    // MARK: - Initializers

    init(viewController: UserProfileViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension UserProfilePresenter: UserProfilePresenterLogic {
    func presentUserData(name: String?, surname: String?) {
        viewController?.presentUserData(
            name: name?.capitalized,
            surname: surname?.capitalized)
    }
}
