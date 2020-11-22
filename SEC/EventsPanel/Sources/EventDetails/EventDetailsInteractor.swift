import UIKit
import Location
import Networking
import CoreLocation
import Core
import Authentication

protocol EventDetailsInteractorLogic {
    func isUserLoggedIn() -> Bool
    func signUp()
    func signOut()
    func viewDidLoad()
}
protocol EventDetailsDataStore {}

final class EventDetailsInteractor: EventDetailsDataStore {
    
    // MARK: - Private Properties
    
    private let presenter: EventDetailsPresenterLogic
    private let eventId: String
    private var locationWorker: LocationWorkerProtocol
    private let networkingWorker: NetworkingWorkerProtocol
    private let dateHelper: DateHelper
    private var authenticationWorker: AuthenticationWorkerProtocol
    
    // MARK: - Initializers
    
    init(presenter: EventDetailsPresenterLogic,
         eventId: String,
         locationWorker: LocationWorkerProtocol,
         networkingWorker: NetworkingWorkerProtocol,
         dateHelper: DateHelper,
         authenticationWorker: AuthenticationWorkerProtocol) {
        self.presenter = presenter
        self.eventId = eventId
        self.locationWorker = locationWorker
        self.networkingWorker = networkingWorker
        self.dateHelper = dateHelper
        self.authenticationWorker = authenticationWorker
    }
    
    // MARK: - Private Methods
    
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
    
    func isUserSignedUp() {
        guard let userId = authenticationWorker.user?.uid else { return }
        
        networkingWorker.request(
            query: IsSignedUpQuery(
                userId: userId,
                eventId: eventId)) { [weak self] (result) in
            switch result {
            case let .success(result):
                self?.presenter.preapareButtons(isUserSignedUp: result.data?.eventsParticipants.isEmpty ?? true)
            case let .failure(error):
                //TODO: Present error
                print(error)
            }
        }
    }
}

extension EventDetailsInteractor: EventDetailsInteractorLogic {
    func viewDidLoad() {
        fetchEventData()
        isUserSignedUp()
    }
    
    func signOut() {
        guard let userId = authenticationWorker.user?.uid else { return }
        
        networkingWorker.perform(
            mutation: DeleteEventParticipantMutation(
                userId: userId,
                eventId: eventId)) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.viewDidLoad()
            case let .failure(error):
                //TODO: Present error
                print(error)
            }
        }
    }
    
    func signUp() {
        guard let userId = authenticationWorker.user?.uid else { return }
        
        networkingWorker.perform(
            mutation: InsertEventsParticipantsMutation(
                eventId: eventId,
                userId: userId,
                id: eventId + userId)) { [weak self] (result) in
            switch result {
            case .success(_):
                self?.viewDidLoad()
            case let .failure(error):
                //TODO: Present error
                print(error)
            }
        }
    }
    
    
    func isUserLoggedIn() -> Bool {
        return authenticationWorker.user != nil ? true : false
    }
}
