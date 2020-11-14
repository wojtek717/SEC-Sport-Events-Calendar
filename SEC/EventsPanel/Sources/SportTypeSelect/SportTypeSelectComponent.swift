import Core
import NeedleFoundation
import UIKit

public protocol SportTypeSelectDependency: Dependency {}

public protocol SportTypeSelectRouting: RoutesDefinition {}

public final class SportTypeSelectComponent: Component<SportTypeSelectDependency> {
    private weak var delegate: MainEventsListSelectionDelegate?
    private var currentlySelected: [SportType]
    
    public init(parent: Scope,
                delegate: MainEventsListSelectionDelegate?,
                currentlySelected: [SportType]) {
        self.delegate = delegate
        self.currentlySelected = currentlySelected
        
        super.init(parent: parent)
    }
}

extension SportTypeSelectComponent: RoutableComponent {
    public var viewController: UIViewController {
        let viewController = SportTypeSelectViewController(nib: R.nib.sportTypeSelectViewController)

        let presenter = SportTypeSelectPresenter(viewController: viewController)
        let interactor = SportTypeSelectInteractor(presenter: presenter,
                                                   currentlySelected: currentlySelected)
        let router = SportTypeSelectRouter(viewController: viewController,
                                           dataStore: interactor,
                                           routes: self,
                                           delegate: delegate)

        viewController.interactor = interactor
        viewController.router = router

        return viewController
    }
}

extension SportTypeSelectComponent: SportTypeSelectRouting {}
