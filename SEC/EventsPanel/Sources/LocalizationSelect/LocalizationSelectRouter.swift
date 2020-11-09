import UIKit

typealias LocalizationSelectRouterType = LocalizationSelectRouterProtocol

protocol LocalizationSelectRouterProtocol {
    func dismiss()
    func localizationTypeSelected(_ queryLocalizationType: QueryLocalizationType)
}

final class LocalizationSelectRouter {

    // MARK: - Private Properties

    private weak var viewController: LocalizationSelectViewController?
    private let dataStore: LocalizationSelectDataStore

    private let routes: LocalizationSelectRouting
    private weak var delegate: MainEventsListSelectionDelegate?

    // MARK: - Initializers

    init(viewController: LocalizationSelectViewController?,
         dataStore: LocalizationSelectDataStore,
         routes: LocalizationSelectRouting,
         delegate: MainEventsListSelectionDelegate?) {
        self.viewController = viewController
        self.dataStore = dataStore
        self.routes = routes
        self.delegate = delegate
    }
}

extension LocalizationSelectRouter: LocalizationSelectRouterProtocol {
    func localizationTypeSelected(_ queryLocalizationType: QueryLocalizationType) {
        delegate?.didSelectLocalizationType(queryLocalizationType)
        dismiss()
    }
    
    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true)
    }
}
