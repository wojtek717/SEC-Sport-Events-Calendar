import Core
import NeedleFoundation
import UIKit

public protocol SplashRouting: RoutesDefinition {}

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
    
    public var viewController: UIViewController {
        let viewController = SplashViewController(nib: R.nib.splashViewController)
        let presenter = SplashPresenter(viewController: viewController)
        let interactor = SplashInteractor(presenter: presenter)
        let router = SplashRouter(
            viewController: viewController,
            dataStore: interactor,
            routes: self,
            window: keyWindow)
        
        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}

extension SplashComponent: SplashRouting {}
