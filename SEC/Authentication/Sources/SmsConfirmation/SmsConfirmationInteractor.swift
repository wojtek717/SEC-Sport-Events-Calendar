import UIKit
import Networking

protocol SmsConfirmationInteractorLogic {
    func signIn(smsCode: String)
}
protocol SmsConfirmationDataStore {}

final class SmsConfirmationInteractor: SmsConfirmationDataStore {
    
    // MARK: - Private Properties
    
    private let presenter: SmsConfirmationPresenterLogic
    private var authenticationWorker: AuthenticationWorkerProtocol
    private let networkingWorker: NetworkingWorkerProtocol
    
    // MARK: - Initializers
    
    init(presenter: SmsConfirmationPresenterLogic,
         authenticationWorker: AuthenticationWorkerProtocol,
         networkingWorker: NetworkingWorkerProtocol) {
        self.presenter = presenter
        self.authenticationWorker = authenticationWorker
        self.networkingWorker = networkingWorker
    }
    
    private func addUserToDataBase(uuid: String) {
        networkingWorker.perform(
            mutation: InsertNewUserQueryMutation(uuid: uuid)) { [weak self] (_) in
            self?.presenter.presentEventsList()
        }
    }
}

extension SmsConfirmationInteractor: SmsConfirmationInteractorLogic {
    func signIn(smsCode: String) {
        
        guard let verificationID = authenticationWorker.verificationID else { return }
        
        authenticationWorker.signIn(
            verificationID: verificationID,
            verificationCode: smsCode) { [weak self] (_) in
            if let uuid = self?.authenticationWorker.user?.uid {
                self?.addUserToDataBase(uuid: uuid)
            } else {
                self?.presenter.presentEventsList()
            }
        } failure: { (error) in
            print(error)
            //TODO: Display error
        }
        
    }
}
