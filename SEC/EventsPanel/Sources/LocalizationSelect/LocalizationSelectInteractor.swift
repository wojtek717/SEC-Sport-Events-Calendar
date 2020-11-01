import UIKit
import Location

protocol LocalizationSelectInteractorLogic {
    func getPlace()
}
protocol LocalizationSelectDataStore {}

final class LocalizationSelectInteractor: LocalizationSelectDataStore {

    // MARK: - Private Properties

    private let presenter: LocalizationSelectPresenterLogic
    private var locationWorker: LocationWorkerProtocol

    // MARK: - Initializers

    init(presenter: LocalizationSelectPresenterLogic,
         locationWorker: LocationWorkerProtocol) {
        self.presenter = presenter
        self.locationWorker = locationWorker
    }
}

extension LocalizationSelectInteractor: LocalizationSelectInteractorLogic {
    func getPlace() {
        locationWorker.startUpdatingLocation()
        guard let location = locationWorker.currentLocation else {
            return
        }
        
        locationWorker.getPlace(for: location) { [weak self] (placemark) in
            guard let placemark = placemark else {
                return
            }
            self?.presenter.presentUserPlace(placeMark: placemark)
        }
    }
}
