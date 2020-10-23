import UIKit

protocol MainEventsListViewControllerLogic: AnyObject {}

final class MainEventsListViewController: UIViewController {

    // MARK: - Public Properties

    var interactor: MainEventsListInteractorLogic?
    var router: MainEventsListRouterType?
    
    // MARK: - View Methods
    override func viewDidLoad() {
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        navigationController?.isNavigationBarHidden = true
    }
}

extension MainEventsListViewController: MainEventsListViewControllerLogic {}
