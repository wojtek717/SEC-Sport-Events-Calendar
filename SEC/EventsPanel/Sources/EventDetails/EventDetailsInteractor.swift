import UIKit
import Location
import Networking
import CoreLocation
import Core

protocol EventDetailsInteractorLogic {
    func fetchEventData()
}
protocol EventDetailsDataStore {}

final class EventDetailsInteractor: EventDetailsDataStore {
    
    // MARK: - Private Properties
    
    private let presenter: EventDetailsPresenterLogic
    private let eventId: String
    private var locationWorker: LocationWorkerProtocol
    private let networkingWorker: NetworkingWorkerProtocol
    private let dateHelper: DateHelper
    
    // MARK: - Initializers
    
    init(presenter: EventDetailsPresenterLogic,
         eventId: String,
         locationWorker: LocationWorkerProtocol,
         networkingWorker: NetworkingWorkerProtocol,
         dateHelper: DateHelper) {
        self.presenter = presenter
        self.eventId = eventId
        self.locationWorker = locationWorker
        self.networkingWorker = networkingWorker
        self.dateHelper = dateHelper
    }
}

extension EventDetailsInteractor: EventDetailsInteractorLogic {
    func fetchEventData() {
        networkingWorker.request(
            query: GetEventQuery(id: eventId)) { [weak self] (result) in
            switch result {
            case let .success(result):
                guard let fetchedEvent = result.data?.events.first else { return }
                
                self?.locationWorker.getPlace(
                    for: CLLocation(
                        latitude: fetchedEvent.localization.latitude,
                        longitude: fetchedEvent.localization.longitude), completion: { (placemark) in
                            
                            let event = EventDetails(
                                title: fetchedEvent.title,
                                description: fetchedEvent.description,
                                startDate: self?.dateHelper.convertGraphQLDateToDate(fetchedEvent.beginDate),
                                endDate: self?.dateHelper.convertGraphQLDateToDate(fetchedEvent.endDate),
                                signedUp: fetchedEvent.eventsParticipantsAggregate.aggregate?.count ?? 0,
                                maxParticipants: fetchedEvent.maxParticipant ?? 0,
                                placemark: placemark)
                            
                            self?.presenter.preapareEventDetails(with: event)
                        })
                
            case let .failure(error):
                print(error)
            }
        }
    }
}




