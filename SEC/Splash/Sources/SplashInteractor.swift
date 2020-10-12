import UIKit

protocol SplashInteractorLogic {}
protocol SplashDataStore {}

final class SplashInteractor: SplashDataStore {

    // MARK: - Private Properties

    private let presenter: SplashPresenterLogic

    // MARK: - Initializers

    init(presenter: SplashPresenterLogic) {
        self.presenter = presenter
    }
}

extension SplashInteractor: SplashInteractorLogic {}
