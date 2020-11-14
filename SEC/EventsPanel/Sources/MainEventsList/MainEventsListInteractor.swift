import Core
import UIKit
import Networking
import Location
import CoreLocation

protocol MainEventsListInteractorLogic {
    func fetchEvents(localizationType: QueryLocalizationType, sportTypes: [SportType])
}
protocol MainEventsListDataStore {}

final class MainEventsListInteractor: MainEventsListDataStore {
    
    private enum Constants {
        static let eartPerimeter = 40075000.0 // in meters
        static let fetchRadious = 15000.0 // in meters
        static var fetchLatRadiousDegree: Double {
            return 360.0 * fetchRadious / eartPerimeter
        }
        
        static func fetchLongRadiousDegree(lat: Double) -> Double {
            return 360 * Constants.fetchRadious / Constants.eartPerimeter * cos(lat)
        }
    }
    
    // MARK: - Private Properties
    
    private let presenter: MainEventsListPresenterLogic
    private let locationWorker: LocationWorkerProtocol
    private let networkingWorker: NetworkingWorkerProtocol
    private let dateHelper: DateHelper
    
    
    var events = [GetAllEventsQuery.Data.Event]()
    
    // MARK: - Initializers
    
    init(presenter: MainEventsListPresenterLogic,
         locationWorker: LocationWorkerProtocol,
         networkingWorker: NetworkingWorkerProtocol,
         dateHelper: DateHelper) {
        self.presenter = presenter
        self.locationWorker = locationWorker
        self.networkingWorker = networkingWorker
        self.dateHelper = dateHelper
    }
    
    private func fetchEventsFromEverywhere(sportTypes: [Int]) {
        networkingWorker.request(query: GetAllEventsQuery(sportTypes: sportTypes)) { [weak self] (result) in
            switch result {
            case .success(let graphqlResult):
                let eventsRows: [MainEventsListRow]? = graphqlResult.data?.events.compactMap { [weak self] in
                    
                    guard let sport = SportType(rawValue: $0.type) else {
                        return nil
                    }
                    
                    return MainEventsListRow.event(
                        EventTableViewCellPresentable(
                            title: $0.title,
                            date: self?.dateHelper.convertDateToString(
                                self?.dateHelper.convertGraphQLDateToDate($0.beginDate),
                                with: DateHelper.Constants.monthDayYearFormat) ?? "",
                            city: "cityHere",
                            sport: sport))
                }
                
                if let eventsRows = eventsRows {
                    self?.presenter.presentEvents(events: eventsRows)
                }
                
            case .failure(let error):
                //TODO: Handle error
                print(error)
            }
        }
    }
    
    private func fetchEventsAroudLocalization(sportTypes: [Int], localization: CLLocationCoordinate2D) {
        let startLat = localization.latitude - Constants.fetchLatRadiousDegree
        let endLat = localization.latitude + Constants.fetchLatRadiousDegree
        
        let startLong = localization.longitude - Constants.fetchLongRadiousDegree(lat: localization.latitude)
        let endLong = localization.longitude + Constants.fetchLongRadiousDegree(lat: localization.latitude)
        
        networkingWorker.request(query: GetEventsAroundQuery(sportTypes: sportTypes,
                                                             latLte: max(startLat, endLat),
                                                             latGte: min(startLat, endLat),
                                                             longLte: max(startLong, endLong),
                                                             longGte: min(startLong, endLong))) { [weak self] (result) in
            switch result {
            case .success(let graphqlResult):
                let eventsRows: [MainEventsListRow]? = graphqlResult.data?.events.compactMap { [weak self] in
                    
                    guard let sport = SportType(rawValue: $0.type) else {
                        return nil
                    }
                    
                    return MainEventsListRow.event(
                        EventTableViewCellPresentable(
                            title: $0.title,
                            date: self?.dateHelper.convertDateToString(
                                self?.dateHelper.convertGraphQLDateToDate($0.beginDate),
                                with: DateHelper.Constants.monthDayYearFormat) ?? "",
                            city: "cityHere",
                            sport: sport))
                }
                
                if let eventsRows = eventsRows {
                    self?.presenter.presentEvents(events: eventsRows)
                }
                
            case .failure(let error):
                //TODO: Handle error
                print(error)
            }
        }
    }
}

extension MainEventsListInteractor: MainEventsListInteractorLogic {
    func fetchEvents(localizationType: QueryLocalizationType, sportTypes: [SportType]) {
        let sportTypeValues = sportTypes.map { $0.rawValue }
        
        switch localizationType {
        case .everywhere:
            fetchEventsFromEverywhere(sportTypes: sportTypeValues)
        case .atUserLocalization:
            guard let localization = locationWorker.currentLocation?.coordinate else {
                return
            }
            fetchEventsAroudLocalization(sportTypes: sportTypeValues, localization: localization)
        case let .atSelectedLocalization(item):
            fetchEventsAroudLocalization(sportTypes: sportTypeValues, localization: item.placemark.coordinate)
        }
    }
}
