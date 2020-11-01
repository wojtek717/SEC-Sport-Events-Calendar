import UIKit

protocol MainEventsListViewControllerLogic: AnyObject {}

final class MainEventsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var topMenuView: UIView!
    @IBOutlet var topMenuTopConstraint: NSLayoutConstraint!
    @IBOutlet var botMenuItem1: BotMenuItemView!
    @IBOutlet var botMenuItem2: BotMenuItemView!
    @IBOutlet var botMenuItem3: BotMenuItemView!
    
    // MARK: - Private Properties
    
    private var dataSource = MainEventsListDataSource()
    private var range: Range<CGFloat> = (0..<0)
    
    // MARK: - Public Properties
    
    var interactor: MainEventsListInteractorLogic?
    var router: MainEventsListRouterType?
    
    // MARK: - View Methods
    override func viewDidLoad() {
        setup()
        setupTableView()
        setupBotMenu()
        
        dataSource.content = [
            MainEventsListRow.event(EventTableViewCellPresentable(title: "Bieg Niepodleglosci 2020",
                                                                  date: "11/11 12:30",
                                                                  city: "Wroclaw",
                                                                  sport: .running)),
        ]
        tableView.reloadData()
        
        interactor?.fetchEvents()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        navigationController?.isNavigationBarHidden = true
        
        range = ((topMenuView.frame.height - 1) * -1)..<0
    }
    
    private func setupTableView() {
        tableView.register(R.nib.eventTableViewCell)
        tableView.dataSource = dataSource
        tableView.delegate = dataSource
        dataSource.use(mainEventsListDelegate: self)
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.bouncesZoom = false
    }
    
    private func setupBotMenu() {
        botMenuItem1.setup(itemType: .signedUp, delegate: self)
        botMenuItem2.setup(itemType: .add, delegate: self)
        botMenuItem3.setup(itemType: .profile, delegate: self)
    }
}

extension MainEventsListViewController: MainEventsListViewControllerLogic {}

extension MainEventsListViewController: MenuItemDelegate {
    func didTapItem(_ itemType: MenuItemType) {
        print("==== tapped \(itemType.title)")
    }
}

extension MainEventsListViewController: MainEventsListDelegate {
    func scrollViewDidScroll(delta: CGFloat) {
        if delta < 0 {
            topMenuTopConstraint.constant = min(topMenuTopConstraint.constant - delta, range.upperBound)
        } else {
            topMenuTopConstraint.constant = max(range.lowerBound, topMenuTopConstraint.constant - delta)
        }
    }
    
    func didSelectItem(_ mainEventsListItem: MainEventsListRow, atIndex index: Int) {
        // TODO: Handle selection
    }
}
