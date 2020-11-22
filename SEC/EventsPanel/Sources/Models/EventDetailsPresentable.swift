import UIKit
import CoreLocation

public struct EventDetailsPresentable {
    let title: String
    let description: String
    let startDate: String
    let endDate: String
    let signedUp: String
    let city: String
    let postCode: String
    let localizationName: String
}

public struct EventDetails {
    let title: String
    let description: String
    let startDate: Date?
    let endDate: Date?
    let signedUp: Int
    let maxParticipants: Int
    let placemark: CLPlacemark?
}
