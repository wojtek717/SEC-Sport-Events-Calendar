import UIKit

protocol CreatorFirstStepInteractorLogic {
    func setTitle(_ title: String)
}
protocol CreatorFirstStepDataStore {
    var eventEntity: EventEntity { get }
}

final class CreatorFirstStepInteractor: CreatorFirstStepDataStore {
    
    var eventEntity: EventEntity

    // MARK: - Private Properties

    private let presenter: CreatorFirstStepPresenterLogic

    // MARK: - Initializers

    init(presenter: CreatorFirstStepPresenterLogic,
         eventEntity: EventEntity) {
        self.presenter = presenter
        self.eventEntity = eventEntity
    }
}

extension CreatorFirstStepInteractor: CreatorFirstStepInteractorLogic {
    func setTitle(_ title: String) {
        eventEntity.title = title
    }
}
