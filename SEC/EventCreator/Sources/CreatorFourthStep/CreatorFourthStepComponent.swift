import Core
import NeedleFoundation
import UIKit
import Location

public protocol CreatorFourthStepDependency: Dependency {
    var locationWorker: LocationWorkerProtocol { get }
}

public protocol CreatorFourthStepRouting: RoutesDefinition {}

public final class CreatorFourthStepComponent: Component<CreatorFourthStepDependency>, RoutableComponent {
    
    var eventEntity: EventEntity
    
    public init(parent: Scope, eventEntity: EventEntity) {
        self.eventEntity = eventEntity
        
        super.init(parent: parent)
    }

    public var viewController: UIViewController {
        let viewController = CreatorFourthStepViewController(nib: R.nib.creatorFourthStepViewController)

        let presenter = CreatorFourthStepPresenter(viewController: viewController)
        let interactor = CreatorFourthStepInteractor(presenter: presenter,
                                                     locationWorker: dependency.locationWorker,
                                                     debounceWorker: debounceWorker, eventEntity: eventEntity)
        let router = CreatorFourthStepRouter(viewController: viewController, dataStore: interactor, routes: self)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
    
    var debounceWorker: DebounceWorker {
        DebounceWorker(interval: 0.5)
    }
}

extension CreatorFourthStepComponent: CreatorFourthStepRouting {}
