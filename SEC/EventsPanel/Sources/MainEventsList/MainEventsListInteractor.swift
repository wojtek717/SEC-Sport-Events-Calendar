import UIKit

protocol MainEventsListInteractorLogic {}
protocol MainEventsListDataStore {}

final class MainEventsListInteractor: MainEventsListDataStore {

    // MARK: - Private Properties

    private let presenter: MainEventsListPresenterLogic

    // MARK: - Initializers

    init(presenter: MainEventsListPresenterLogic) {
        self.presenter = presenter
    }
}

extension MainEventsListInteractor: MainEventsListInteractorLogic {}
