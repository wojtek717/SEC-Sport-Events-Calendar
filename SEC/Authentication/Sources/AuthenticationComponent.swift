import Core
import NeedleFoundation
import UIKit
import Firebase
import Networking

public protocol AuthenticationRouting: RoutesDefinition {
    var enterPhoneNumber: EnterPhoneNumberComponent { get }
}

// This is to ensure only one instance of auth component across the apps.
public let authenticationComponent = AuthenticationComponent()

public final class AuthenticationComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()
        FirebaseApp.configure()
        
        super.init()
    }
    
    public var authenticationWorker: AuthenticationWorkerProtocol {
        shared { AuthenticationWorker() }
    }
    
    var networkingWorker: NetworkingWorkerProtocol {
        networkingComponent.networkingWorker
    }
 }

extension AuthenticationComponent: AuthenticationRouting {
    public var enterPhoneNumber: EnterPhoneNumberComponent {
        EnterPhoneNumberComponent(parent: self)
    }
}
