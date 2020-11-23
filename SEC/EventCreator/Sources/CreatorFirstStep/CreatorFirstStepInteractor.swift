import UIKit

protocol CreatorFirstStepInteractorLogic {}
protocol CreatorFirstStepDataStore {}

final class CreatorFirstStepInteractor: CreatorFirstStepDataStore {

    // MARK: - Private Properties

    private let presenter: CreatorFirstStepPresenterLogic

    // MARK: - Initializers

    init(presenter: CreatorFirstStepPresenterLogic) {
        self.presenter = presenter
    }
}

extension CreatorFirstStepInteractor: CreatorFirstStepInteractorLogic {}
