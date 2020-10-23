import UIKit

protocol MainEventsListViewControllerLogic: AnyObject {}

final class MainEventsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private var dataSource = MainEventsListDataSource()
    
    // MARK: - Public Properties
    
    var interactor: MainEventsListInteractorLogic?
    var router: MainEventsListRouterType?
    
    // MARK: - View Methods
    override func viewDidLoad() {
        setup()
        setupTableView()
        
        dataSource.content = [
            MainEventsListRow.event(EventTableViewCellPresentable(title: "Bieg Niepodleglosci 2020",
                                                                  date: "11/11 12:30",
                                                                  city: "Wroclaw",
                                                                  sport: .running))
        ]
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setupTableView() {
        tableView.register(R.nib.eventTableViewCell)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        dataSource.use(mainEventsListDelegate: self)
        tableView.separatorStyle = .none
    }
}

extension MainEventsListViewController: MainEventsListViewControllerLogic {}

extension MainEventsListViewController: MainEventsListDelegate {
    func didSelectItem(_ mainEventsListItem: MainEventsListRow, atIndex index: Int) {
        // TODO: Handle selection
    }
}
