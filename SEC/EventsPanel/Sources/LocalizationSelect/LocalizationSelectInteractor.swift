import Core
import UIKit
import Location

@objc protocol LocalizationSelectInteractorLogic {
    func getPlace()
    func textFieldDidChange(_ textField: UITextField)
}
protocol LocalizationSelectDataStore {}

final class LocalizationSelectInteractor: LocalizationSelectDataStore {

    // MARK: - Private Properties

    private let presenter: LocalizationSelectPresenterLogic
    private var locationWorker: LocationWorkerProtocol
    private var debounceWorker: DebounceWorker

    // MARK: - Initializers

    init(presenter: LocalizationSelectPresenterLogic,
         locationWorker: LocationWorkerProtocol,
         debounceWorker: DebounceWorker) {
        self.presenter = presenter
        self.locationWorker = locationWorker
        self.debounceWorker = debounceWorker
    }
    
    // MARK: - Private Methods
    
    private func search(for name: String) {
        locationWorker.search(for: name) { (response) in
            if let response = response?.mapItems {
                self.presenter.presentSearchResponse(response: response)
            }
        }
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
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        guard let searchQuery = textField.text,
              searchQuery.count >= 3 else {
            presenter.presentSearchResponse(response: [])
            return
        }
        
        debounceWorker.debounce { [weak self] in
            self?.search(for: searchQuery)
        }
    }
}
