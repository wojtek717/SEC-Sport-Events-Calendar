import UIKit

protocol SmsConfirmationInteractorLogic {
    func signIn(smsCode: String)
}
protocol SmsConfirmationDataStore {}

final class SmsConfirmationInteractor: SmsConfirmationDataStore {

    // MARK: - Private Properties

    private let presenter: SmsConfirmationPresenterLogic
    private var authenticationWorker: AuthenticationWorkerProtocol

    // MARK: - Initializers

    init(presenter: SmsConfirmationPresenterLogic,
         authenticationWorker: AuthenticationWorkerProtocol) {
        self.presenter = presenter
        self.authenticationWorker = authenticationWorker
    }
}

extension SmsConfirmationInteractor: SmsConfirmationInteractorLogic {
    func signIn(smsCode: String) {
        
        guard let verificationID = authenticationWorker.verificationID else { return }
        
        authenticationWorker.signIn(
            verificationID: verificationID,
            verificationCode: smsCode) { [weak self] (_) in
            self?.presenter.presentEventsList()
        } failure: { (error) in
            print(error)
            //TODO: Display error
        }

    }
}
