import UIKit

protocol CreatorFirstStepInteractorLogic {
    func setTitle(_ title: String)
}
protocol CreatorFirstStepDataStore {}

final class CreatorFirstStepInteractor: CreatorFirstStepDataStore {

    // MARK: - Private Properties

    private let presenter: CreatorFirstStepPresenterLogic
    private var eventEntity = EventEntity()

    // MARK: - Initializers

    init(presenter: CreatorFirstStepPresenterLogic) {
        self.presenter = presenter
    }
}

extension CreatorFirstStepInteractor: CreatorFirstStepInteractorLogic {
    func setTitle(_ title: String) {
        eventEntity.title = title
    }
}
