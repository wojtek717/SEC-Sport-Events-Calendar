import CoreLocation
import Foundation

public struct Location {
    public let position: CLLocationCoordinate2D
    public let heading: CLHeading
    public let accuracy: CLLocationAccuracy
    public let location: CLLocation
}
