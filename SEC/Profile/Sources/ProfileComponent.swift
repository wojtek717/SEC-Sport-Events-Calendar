import Core
import NeedleFoundation
import UIKit
import Authentication
import Networking

public protocol ProfileRouting: RoutesDefinition {
    var userProfile: UserProfileComponent { get }
}

public final class ProfileComponent: BootstrapComponent {
    public override init() {
        registerProviderFactories()

        super.init()
    }
    
    public var authenticationWorker: AuthenticationWorkerProtocol {
        authenticationComponent.authenticationWorker
    }
    
    var networkingWorker: NetworkingWorkerProtocol {
        networkingComponent.networkingWorker
    }
 }

extension ProfileComponent: ProfileRouting {
    public var userProfile: UserProfileComponent {
        UserProfileComponent(parent: self)
    }
}
