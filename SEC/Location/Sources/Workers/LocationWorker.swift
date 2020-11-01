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
    var currentLocation: CLLocation? { get }
    var authorizationStatus: CLAuthorizationStatus { get }
    func startUpdatingLocation()
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void)
}

public final class LocationWorker: NSObject, LocationWorkerProtocol {
    
    // MARK: - Public Properties
    
    public weak var delegate: LocationWorkerDelegate?
    
    public var currentLocation: CLLocation? {
        return manager.location
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
    
    public func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            
            guard error == nil else {
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
}

extension LocationWorker: CLLocationManagerDelegate {
    public func locationManager(_ manager: CLLocationManager,
                                didChangeAuthorization status: CLAuthorizationStatus) {
        let isAuthorized = status == .authorizedWhenInUse || status == .authorizedAlways
        delegate?.locationWorker(self, didChangeAuthorizationStatus: isAuthorized)
    }
}
