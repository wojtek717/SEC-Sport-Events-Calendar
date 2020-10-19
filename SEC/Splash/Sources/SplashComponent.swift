import Core
import NeedleFoundation
import UIKit
import Onboarding
import Location

public protocol SplashRouting: RoutesDefinition {
    var onboarding: OnboardingComponent { get }
}

public final class SplashComponent: BootstrapComponent, RoutableBootstrapComponent {
    override public init() {
        registerProviderFactories()
        
        super.init()
    }
    
    var keyWindow: UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    var userDefaults: UserDefaults {
        UserDefaults.standard
    }
    
    var locationWorker: LocationWorkerProtocol {
        locationComponent.locationWorker
    }
    
    public var viewController: UIViewController {
        let viewController = SplashViewController(nib: R.nib.splashViewController)
        let presenter = SplashPresenter(viewController: viewController)
        let interactor = SplashInteractor(presenter: presenter)
        let router = SplashRouter(
            viewController: viewController,
            dataStore: interactor,
            routes: self,
            window: keyWindow,
            locationWorker: locationWorker)
        
        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}

extension SplashComponent: SplashRouting {
    public var onboarding: OnboardingComponent {
        OnboardingComponent()
    }
}
