import UIKit

public protocol MainEventsListSelectionDelegate: AnyObject {
    func didSelectLocalizationType(_ queryLocalizationType: QueryLocalizationType)
    func didSelectSpotyTypes(_ sportTypes: [SportType])
}

