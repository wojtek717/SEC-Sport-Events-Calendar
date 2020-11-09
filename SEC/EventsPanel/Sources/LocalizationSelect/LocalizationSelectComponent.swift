import Core
import NeedleFoundation
import UIKit
import Location

public protocol LocalizationSelectDependency: Dependency {
    var locationWorker: LocationWorkerProtocol { get }
}

public protocol LocalizationSelectRouting: RoutesDefinition {}

public final class LocalizationSelectComponent: Component<LocalizationSelectDependency> {
    private weak var delegate: MainEventsListSelectionDelegate?
    
    public init(parent: Scope, delegate: MainEventsListSelectionDelegate?) {
        self.delegate = delegate
        
        super.init(parent: parent)
    }
    
}

extension LocalizationSelectComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = LocalizationSelectViewController(nib: R.nib.localizationSelectViewController)

        let presenter = LocalizationSelectPresenter(viewController: viewController)
        let interactor = LocalizationSelectInteractor(presenter: presenter,
                                                      locationWorker: dependency.locationWorker,
                                                      debounceWorker: debounceWorker)
        let router = LocalizationSelectRouter(viewController: viewController, dataStore: interactor, routes: self, delegate: delegate)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
    
    var debounceWorker: DebounceWorker {
        DebounceWorker(interval: 0.5)
    }
}

extension LocalizationSelectComponent: LocalizationSelectRouting {}
