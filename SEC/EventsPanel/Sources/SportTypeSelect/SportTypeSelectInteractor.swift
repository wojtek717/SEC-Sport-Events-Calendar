import UIKit
import CommonUI

protocol SportTypeSelectInteractorLogic {
    func prepareSports()
    func sportSelected(_ sport: SportType)
    
    var currentlySelected: [SportType] { get }
}
protocol SportTypeSelectDataStore {}

final class SportTypeSelectInteractor: SportTypeSelectDataStore {

    // MARK: - Private Properties

    private let presenter: SportTypeSelectPresenterLogic
    private(set) var currentlySelected: [SportType]

    // MARK: - Initializers

    init(presenter: SportTypeSelectPresenterLogic,
         currentlySelected: [SportType]) {
        self.presenter = presenter
        self.currentlySelected = currentlySelected
    }
}

extension SportTypeSelectInteractor: SportTypeSelectInteractorLogic {
    func prepareSports() {
        presenter.presentSports(selectedSports: currentlySelected)
    }
    
    func sportSelected(_ sport: SportType) {
        if currentlySelected.contains(sport) {
            currentlySelected.removeAll { $0 == sport }
        } else {
            currentlySelected.append(sport)
        }
        
        presenter.presentSports(selectedSports: currentlySelected)
    }
    
}
