import UIKit

protocol CreatorSecondStepInteractorLogic {
    func setDescription(_ description: String)
}

protocol CreatorSecondStepDataStore {
    var eventEntity: EventEntity { get }
}

final class CreatorSecondStepInteractor: CreatorSecondStepDataStore {
    
    var eventEntity: EventEntity

    // MARK: - Private Properties

    private let presenter: CreatorSecondStepPresenterLogic

    // MARK: - Initializers

    init(presenter: CreatorSecondStepPresenterLogic,
         eventEntity: EventEntity) {
        self.presenter = presenter
        self.eventEntity = eventEntity
        
        print("==== \(eventEntity.title)")
    }
}

extension CreatorSecondStepInteractor: CreatorSecondStepInteractorLogic {
    func setDescription(_ description: String) {
        eventEntity.description = description
    }
}
