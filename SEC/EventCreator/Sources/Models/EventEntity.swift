import UIKit
import CoreLocation
import CommonUI

public struct EventEntity {
    var sportType: SportType
    var title: String?
    var description: String?
    var startDate: Date?
    var endDate: Date?
    var maxParticipants: Int?
    var latitude: Double?
    var longitude: Double?
}
