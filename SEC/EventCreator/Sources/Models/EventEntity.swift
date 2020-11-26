import UIKit
import CoreLocation

public struct EventEntity {
    var title: String?
    var description: String?
    var startDate: Date?
    var endDate: Date?
    var maxParticipants: Int?
    var localization: CLLocation?
}
