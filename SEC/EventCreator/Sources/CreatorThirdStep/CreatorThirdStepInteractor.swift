import UIKit

protocol CreatorThirdStepInteractorLogic {
    func setDate(beginDate: Date, endDate: Date)
}
protocol CreatorThirdStepDataStore {
    var eventEntity: EventEntity { get }
}

final class CreatorThirdStepInteractor: CreatorThirdStepDataStore {
    
    var eventEntity: EventEntity

    // MARK: - Private Properties

    private let presenter: CreatorThirdStepPresenterLogic

    // MARK: - Initializers

    init(presenter: CreatorThirdStepPresenterLogic,
         eventEntity: EventEntity) {
        self.presenter = presenter
        self.eventEntity = eventEntity
        
        print(eventEntity.description)
    }
}

extension CreatorThirdStepInteractor: CreatorThirdStepInteractorLogic {
    func setDate(beginDate: Date, endDate: Date) {
        eventEntity.startDate = beginDate
        eventEntity.endDate = endDate
    }
}
