import UIKit

protocol SportTypeSelectInteractorLogic {}
protocol SportTypeSelectDataStore {}

final class SportTypeSelectInteractor: SportTypeSelectDataStore {

    // MARK: - Private Properties

    private let presenter: SportTypeSelectPresenterLogic
    private var currentlySelected: [SportType]

    // MARK: - Initializers

    init(presenter: SportTypeSelectPresenterLogic,
         currentlySelected: [SportType]) {
        self.presenter = presenter
        self.currentlySelected = currentlySelected
    }
}

extension SportTypeSelectInteractor: SportTypeSelectInteractorLogic {}
