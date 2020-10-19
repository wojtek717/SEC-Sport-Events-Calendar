import Foundation
import CoreLocation

public protocol LocationWorkerDelegate: AnyObject {
    func locationWorker(_ worker: LocationWorker, didChangeAuthorizationStatus isAuthorized: Bool)
}

public extension LocationWorkerDelegate {
    func locationWorker(_ worker: LocationWorker, didChangeAuthorizationStatus isAuthorized: Bool) {}
}

public protocol LocationWorkerProtocol {
    var delegate: LocationWorkerDelegate? { get set }
    var currentLocation: Location? { get }
    var authorizationStatus: CLAuthorizationStatus { get }
    func startUpdatingLocation()
}

public final class LocationWorker: NSObject, LocationWorkerProtocol {
    // MARK: - Public Properties
    
    public weak var delegate: LocationWorkerDelegate?
    
    public var currentLocation: Location? {
        guard let location = manager.location,
              let heading = manager.heading else {
            return nil
        }
        
        return Location(position: location.coordinate, heading: heading, accuracy: location.horizontalAccuracy)
    }
    
    public var authorizationStatus: CLAuthorizationStatus {
        return manager.authorizationStatus
    }
    
    // MARK: - Private Properties
    
    private lazy var manager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.activityType = .automotiveNavigation
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        return manager
    }()
    
    // MARK: - Public Methods
    
    public func startUpdatingLocation() {
        manager.requestAlwaysAuthorization()
        
        manager.startUpdatingLocation()
        manager.startUpdatingHeading()
    }
}

extension LocationWorker: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        let isAuthorized = status == .authorizedWhenInUse || status == .authorizedAlways
        delegate?.locationWorker(self, didChangeAuthorizationStatus: isAuthorized)
    }
}
