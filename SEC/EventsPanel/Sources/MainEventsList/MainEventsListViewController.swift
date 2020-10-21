import UIKit

protocol MainEventsListViewControllerLogic: AnyObject {}

final class MainEventsListViewController: UIViewController {

    // MARK: - Public Properties

    var interactor: MainEventsListInteractorLogic?
    var router: MainEventsListRouterType?
}

extension MainEventsListViewController: MainEventsListViewControllerLogic {}
