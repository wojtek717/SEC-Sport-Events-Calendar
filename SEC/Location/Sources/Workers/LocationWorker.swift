import Foundation
import CoreLocation
import MapKit

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
    func search(for name: String,
                completion: @escaping (MKLocalSearch.Response?) -> Void)
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
    
    public func search(for name: String,
                       completion: @escaping (MKLocalSearch.Response?) -> Void) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = name
        
        if let centerCoordinations = manager.location?.coordinate {
            searchRequest.region = MKCoordinateRegion(center: centerCoordinations,
                                                      latitudinalMeters: 500, longitudinalMeters: 500)
        }
        
        let search = MKLocalSearch(request: searchRequest)
        
        search.start { (reposnse, error) in
            guard error == nil else{
                completion(nil)
                return
            }
            
            completion(reposnse)
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
