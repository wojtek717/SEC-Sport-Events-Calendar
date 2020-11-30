import UIKit
import CommonUI

protocol CreatorSportTypeInteractorLogic {
    func sportSelected(_ sport: SportType)
}
protocol CreatorSportTypeDataStore {}

final class CreatorSportTypeInteractor: CreatorSportTypeDataStore {

    // MARK: - Private Properties

    private let presenter: CreatorSportTypePresenterLogic
    private weak var delegate: MainEventsListCreatorDelegate?

    // MARK: - Initializers

    init(presenter: CreatorSportTypePresenterLogic,
         delegate: MainEventsListCreatorDelegate?) {
        self.presenter = presenter
        self.delegate = delegate
    }
}

extension CreatorSportTypeInteractor: CreatorSportTypeInteractorLogic {
    func sportSelected(_ sport: SportType) {
        delegate?.didSportTypeSelected(sport)
    }
}
