import UIKit
import Location

protocol OnboardingLocationInteractorLogic {
    func askForLocationPermission()
}
protocol OnboardingLocationDataStore {}

final class OnboardingLocationInteractor: OnboardingLocationDataStore {
    
    // MARK: - Private Properties
    
    private let presenter: OnboardingLocationPresenterLogic
    private var locationWorker: LocationWorkerProtocol
    
    // MARK: - Initializers
    
    init(presenter: OnboardingLocationPresenterLogic,
         locationWorker: LocationWorkerProtocol) {
        self.presenter = presenter
        self.locationWorker = locationWorker
        self.locationWorker.delegate = self
    }
}

extension OnboardingLocationInteractor: OnboardingLocationInteractorLogic {
    func askForLocationPermission() {
        locationWorker.startUpdatingLocation()
    }
}

extension OnboardingLocationInteractor: LocationWorkerDelegate {
    func locationWorker(_ worker: LocationWorker, didChangeAuthorizationStatus isAuthorized: Bool) {
        //TODO: NavigateToSextScreen
    }
}
