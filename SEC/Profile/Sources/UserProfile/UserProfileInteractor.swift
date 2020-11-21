import UIKit
import Authentication
import Networking

protocol UserProfileInteractorLogic {
    func fetchUserData()
    func updateUserData(name: String, surname: String)
    func signOut()
}
protocol UserProfileDataStore {}

final class UserProfileInteractor: UserProfileDataStore {
    
    // MARK: - Private Properties
    
    private let presenter: UserProfilePresenterLogic
    private var authenticationWorker: AuthenticationWorkerProtocol
    private let networkingWorker: NetworkingWorkerProtocol
    
    // MARK: - Initializers
    
    init(presenter: UserProfilePresenterLogic,
         authenticationWorker: AuthenticationWorkerProtocol,
         networkingWorker: NetworkingWorkerProtocol) {
        self.presenter = presenter
        self.authenticationWorker = authenticationWorker
        self.networkingWorker = networkingWorker
    }
}

extension UserProfileInteractor: UserProfileInteractorLogic {
    func signOut() {
        authenticationWorker.signOut { [weak self] in
            self?.presenter.presentMainScreen()
        } failure: { (error) in
            //TODO: present error
            print(error)
        }

    }
    
    func fetchUserData() {
        guard let uuid = authenticationWorker.user?.uid else { return }
        
        networkingWorker.request(
            query: GetUserQuery(uuid: uuid)) { [weak self] (result) in
            switch result {
            case let .success(result):
                self?.presenter.presentUserData(
                    name: result.data?.users.first?.name,
                    surname: result.data?.users.first?.surname)
            case let .failure(error):
                print(error)
            }
        }
    }
    
    func updateUserData(name: String, surname: String) {
        guard let uuid = authenticationWorker.user?.uid else { return }
        
        networkingWorker.perform(
            mutation: UpdateUserQueryMutation(uuid: uuid, name: name, surname: surname)) { [weak self] (result) in
            switch result {
            case let .success(result):
                self?.presenter.presentUserData(
                    name: result.data?.updateUsers?.returning.first?.name,
                    surname: result.data?.updateUsers?.returning.first?.surname)
            case let .failure(error):
                print(error)
            }
        }
    }
}
