import UIKit
import Core
import Location
import MapKit

@objc protocol CreatorFourthStepInteractorLogic {
    func textFieldDidChange(_ textField: UITextField)
    func setLocalization(selected row: Int)
}
protocol CreatorFourthStepDataStore {
    var eventEntity: EventEntity { get }
}

final class CreatorFourthStepInteractor: CreatorFourthStepDataStore {
    
    var eventEntity: EventEntity

    // MARK: - Private Properties

    private let presenter: CreatorFourthStepPresenterLogic
    private var locationWorker: LocationWorkerProtocol
    private var debounceWorker: DebounceWorker
    
    private var mapItems: [MKMapItem] = []

    // MARK: - Initializers

    init(presenter: CreatorFourthStepPresenterLogic,
         locationWorker: LocationWorkerProtocol,
         debounceWorker: DebounceWorker,
         eventEntity: EventEntity) {
        self.presenter = presenter
        self.locationWorker = locationWorker
        self.debounceWorker = debounceWorker
        self.eventEntity = eventEntity
        
        print(eventEntity.startDate)
    }
    
    private func search(for name: String) {
        locationWorker.search(for: name) { (response) in
            if let response = response?.mapItems {
                self.mapItems = response
                self.presenter.presentSearchResponse(response: response)
            }
        }
    }
}

extension CreatorFourthStepInteractor: CreatorFourthStepInteractorLogic {
    func setLocalization(selected row: Int) {
        
        if row <= mapItems.count {
            let coordinate = mapItems[row].placemark.location?.coordinate
            
            eventEntity.latitude = coordinate?.latitude
            eventEntity.longitude = coordinate?.longitude
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
}
