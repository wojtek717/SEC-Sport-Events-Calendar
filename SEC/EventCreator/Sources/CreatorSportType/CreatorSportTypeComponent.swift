import Core
import NeedleFoundation
import UIKit

public protocol CreatorSportTypeDependency: Dependency {}

public protocol CreatorSportTypeRouting: RoutesDefinition {}

public final class CreatorSportTypeComponent: Component<CreatorSportTypeDependency>, RoutableComponent {
    
    private weak var delegate: MainEventsListCreatorDelegate?
    
    public init(parent: Scope, delegate: MainEventsListCreatorDelegate?) {
        self.delegate = delegate
        
        super.init(parent: parent)
    }
    
    public var viewController: UIViewController {
        let viewController = CreatorSportTypeViewController(nib: R.nib.creatorSportTypeViewController)
        
        let presenter = CreatorSportTypePresenter(viewController: viewController)
        let interactor = CreatorSportTypeInteractor(presenter: presenter, delegate: delegate)
        let router = CreatorSportTypeRouter(viewController: viewController, dataStore: interactor, routes: self)
        
        viewController.interactor = interactor
        viewController.router = router
        
        return viewController
    }
}

extension CreatorSportTypeComponent: CreatorSportTypeRouting {}
