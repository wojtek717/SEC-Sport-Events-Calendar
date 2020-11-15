import UIKit

protocol EnterPhoneNumberInteractorLogic {
    func verifyPhoneNumber(phoneNumber: String)
}
protocol EnterPhoneNumberDataStore {}

final class EnterPhoneNumberInteractor: EnterPhoneNumberDataStore {

    // MARK: - Private Properties

    private let presenter: EnterPhoneNumberPresenterLogic
    private var authenticationWorker: AuthenticationWorkerProtocol

    // MARK: - Initializers

    init(presenter: EnterPhoneNumberPresenterLogic,
         authenticationWorker: AuthenticationWorkerProtocol) {
        self.presenter = presenter
        self.authenticationWorker = authenticationWorker
    }
}

extension EnterPhoneNumberInteractor: EnterPhoneNumberInteractorLogic {
    func verifyPhoneNumber(phoneNumber: String) {
        authenticationWorker.verifyPhoneNumber(
            phoneNumber: phoneNumber) { [weak self] (veryficationId) in
            self?.authenticationWorker.verificationID = veryficationId
            self?.presenter.presentSmsConfirmation()
        } failure: { (error) in
            //TODO: present error
            print(error)
        }

    }
}
