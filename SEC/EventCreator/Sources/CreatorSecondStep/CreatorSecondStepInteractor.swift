import UIKit

protocol CreatorSecondStepInteractorLogic {}
protocol CreatorSecondStepDataStore {}

final class CreatorSecondStepInteractor: CreatorSecondStepDataStore {

    // MARK: - Private Properties

    private let presenter: CreatorSecondStepPresenterLogic

    // MARK: - Initializers

    init(presenter: CreatorSecondStepPresenterLogic) {
        self.presenter = presenter
    }
}

extension CreatorSecondStepInteractor: CreatorSecondStepInteractorLogic {}
