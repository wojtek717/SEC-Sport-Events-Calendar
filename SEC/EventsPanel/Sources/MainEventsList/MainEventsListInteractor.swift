import Core
import UIKit
import Networking

protocol MainEventsListInteractorLogic {
    func fetchEvents()
}
protocol MainEventsListDataStore {}

final class MainEventsListInteractor: MainEventsListDataStore {
    
    // MARK: - Private Properties
    
    private let presenter: MainEventsListPresenterLogic
    private let networkingWorker: NetworkingWorkerProtocol
    private let dateHelper: DateHelper
    
    
    var events = [GetAllEventsQuery.Data.Event]()
    
    // MARK: - Initializers
    
    init(presenter: MainEventsListPresenterLogic,
         networkingWorker: NetworkingWorkerProtocol,
         dateHelper: DateHelper) {
        self.presenter = presenter
        self.networkingWorker = networkingWorker
        self.dateHelper = dateHelper
    }
}

extension MainEventsListInteractor: MainEventsListInteractorLogic {
    func fetchEvents() {
        networkingWorker.request(query: GetAllEventsQuery()) { (result) in
            switch result {
            case .success(let graphqlResult):
                let eventsRows: [MainEventsListRow]? = graphqlResult.data?.events.map { [weak self] in
                    MainEventsListRow.event(
                        EventTableViewCellPresentable(
                            title: $0.title,
                            date: self?.dateHelper.convertDateToString(
                                self?.dateHelper.convertGraphQLDateToDate($0.beginDate),
                                with: DateHelper.Constants.monthDayYearFormat) ?? "",
                            city: "cityHere",
                            sport: SportType(rawValue: $0.type) ?? .unknown))
                }
                
                if let eventsRows = eventsRows {
                    //TODO: Present results
                }
                
            case .failure(let error):
                //TODO: Handle error
                print(error)
            }
        }
    }
}
