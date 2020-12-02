import UIKit
import Core

protocol CreatorFifthStepInteractorLogic {
    func setParticipantsValue(_ value: Int)
    func changeParticipantsValue(by value: Int)
}

protocol CreatorFifthStepDataStore {
    var eventEntity: EventEntity { get }
}

final class CreatorFifthStepInteractor: CreatorFifthStepDataStore {
    
    var eventEntity: EventEntity
    
    // MARK: - Private Properties
    
    private let presenter: CreatorFifthStepPresenterLogic
    
    // MARK: - Initializers
    
    init(presenter: CreatorFifthStepPresenterLogic,
         eventEntity: EventEntity) {
        self.presenter = presenter
        self.eventEntity = eventEntity
    }
}

extension CreatorFifthStepInteractor: CreatorFifthStepInteractorLogic {
    func changeParticipantsValue(by value: Int) {
        let valueRange = 0...500
        
        guard let maxParticipants = eventEntity.maxParticipants,
              valueRange.contains(maxParticipants + value) else {
            presenter.errorLabelIsEnabled(true)
            return
        }
        
        eventEntity.maxParticipants = maxParticipants + value
        guard let updatedMaxParticipants = eventEntity.maxParticipants else { return }
        
        presenter.preapareParticipantValue(updatedMaxParticipants)
    }
    
    func setParticipantsValue(_ value: Int) {
        eventEntity.maxParticipants = value
        
        guard let maxParticipants = eventEntity.maxParticipants else { return }
        
        presenter.preapareParticipantValue(maxParticipants)
    }
}
