import UIKit
import Networking
import Core
import CoreLocation

protocol EventDetailsPresenterLogic {
    func preapareEventDetails(with event: EventDetails)
}

final class EventDetailsPresenter {

    // MARK: - Private Properties

    private weak var viewController: EventDetailsViewControllerLogic?
    private let dateHelper: DateHelper

    // MARK: - Initializers

    init(viewController: EventDetailsViewControllerLogic?,
         dateHelper: DateHelper) {
        self.viewController = viewController
        self.dateHelper = dateHelper
    }
}

extension EventDetailsPresenter: EventDetailsPresenterLogic {
    func preapareEventDetails(with event: EventDetails) {
        
        let presentable = EventDetailsPresentable(
            title: event.title,
            description: event.description,
            startDate: Core.R.string.localizable.eventDetails_start_label() + " " + dateHelper.convertDateToString(event.startDate,
                                                                                                              with: DateHelper.Constants.fullDateFullHour),
            endDate: Core.R.string.localizable.eventDetails_end_label() + " " + dateHelper.convertDateToString(event.endDate,
                                                                                                         with: DateHelper.Constants.fullDateFullHour),
            signedUp: Core.R.string.localizable.eventDetails_signed_up_label() + " " +  String(event.signedUp) + "/" + String(event.maxParticipants),
            city: event.placemark?.locality ?? "",
            postCode: event.placemark?.postalCode ?? "",
            localizationName: event.placemark?.name ?? "")
        
        
        viewController?.presentEventDetails(presentable: presentable)
    }
}
