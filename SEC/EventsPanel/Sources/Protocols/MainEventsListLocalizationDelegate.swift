import UIKit

public protocol MainEventsListSelectionDelegate: AnyObject {
    func didSelectLocalizationType(_ queryLocalizationType: QueryLocalizationType)
    func dupaSelect()
}

public extension MainEventsListSelectionDelegate {
    func didSelectLocalizationType(_ queryLocalizationType: QueryLocalizationType){}
    func dupaSelect(){}
}
