import UIKit
import Splash
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var splashComponent: SplashComponent!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        splashComponent = SplashComponent()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let router = InitialRouter(
            window: window,
            nextModule: splashComponent.viewController)
        router.navigateToSplashScreen()
        
        return true
    }
    
}
