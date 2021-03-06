import Core
import UIKit
import MapKit
import Location

@objc protocol LocalizationSelectInteractorLogic {
    func getPlace()
    func textFieldDidChange(_ textField: UITextField)
    func localizationSelected(at row: Int)
    func userLocalizationSelected()
}
protocol LocalizationSelectDataStore {}

final class LocalizationSelectInteractor: LocalizationSelectDataStore {

    // MARK: - Private Properties

    private let presenter: LocalizationSelectPresenterLogic
    private var locationWorker: LocationWorkerProtocol
    private var debounceWorker: DebounceWorker
    
    private var mapItems: [MKMapItem] = []

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
                self.mapItems = response
                self.presenter.presentSearchResponse(response: response)
            }
        }
    }
}

extension LocalizationSelectInteractor: LocalizationSelectInteractorLogic {
    func localizationSelected(at row: Int) {
        if row <= mapItems.count {
            presenter.presentLocalizationEvents(item: mapItems[row])
        }
    }
    
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
            mapItems = []
            presenter.presentSearchResponse(response: [])
            return
        }
        
        debounceWorker.debounce { [weak self] in
            self?.search(for: searchQuery)
        }
    }
    
    func userLocalizationSelected() {
        guard let localization = locationWorker.currentLocation else {
            return
        }
        
        locationWorker.getPlace(for: localization) { [weak self] (placemark) in
            self?.presenter.presentLocalizationEvents(placemark: placemark)
        }
    }
}
