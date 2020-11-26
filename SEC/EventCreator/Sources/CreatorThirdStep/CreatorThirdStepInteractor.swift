import UIKit

protocol CreatorThirdStepInteractorLogic {}
protocol CreatorThirdStepDataStore {}

final class CreatorThirdStepInteractor: CreatorThirdStepDataStore {

    // MARK: - Private Properties

    private let presenter: CreatorThirdStepPresenterLogic

    // MARK: - Initializers

    init(presenter: CreatorThirdStepPresenterLogic) {
        self.presenter = presenter
    }
}

extension CreatorThirdStepInteractor: CreatorThirdStepInteractorLogic {}
