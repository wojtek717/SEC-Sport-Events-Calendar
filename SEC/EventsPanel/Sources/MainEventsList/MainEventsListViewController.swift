import Core
import UIKit

protocol MainEventsListViewControllerLogic: AnyObject {
    func presentEvents(events: [MainEventsListRow])
}

final class MainEventsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var topMenuView: UIView!
    @IBOutlet private var topMenuTopConstraint: NSLayoutConstraint!
    @IBOutlet private var botMenuItem1: BotMenuItemView!
    @IBOutlet private var botMenuItem2: BotMenuItemView!
    @IBOutlet private var botMenuItem3: BotMenuItemView!
    @IBOutlet private var localizationButton: UIButton!
    @IBOutlet private var sportTypeButton: UIButton!
    
    // MARK: - Private Properties
    
    private var dataSource = MainEventsListDataSource()
    private var range: Range<CGFloat> = (0..<0)
    private var searchLocalizationType: QueryLocalizationType? {
        didSet {
            localizationButton.setTitle(searchLocalizationType?.title, for: [])
            interactor?.fetchEvents(localizationType: searchLocalizationType ?? .everywhere,
                                    sportTypes: searchSportTypes ?? SportType.allCases)
        }
    }
    private var searchSportTypes: [SportType]? {
        didSet {
            let title = searchSportTypes?.count == 1 ? searchSportTypes?.first?.title : Core.R.string.localizable.sportType_title()
            sportTypeButton.setTitle(title, for: [])
            
            interactor?.fetchEvents(localizationType: searchLocalizationType ?? .everywhere,
                                    sportTypes: searchSportTypes ?? SportType.allCases)
        }
    }
    
    // MARK: - Public Properties
    
    var interactor: MainEventsListInteractorLogic?
    var router: MainEventsListRouterType?
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        setup()
        setupTableView()
        setupBotMenu()
        setupButtons()
        
        searchLocalizationType = .everywhere
        searchSportTypes = SportType.allCases
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
    
    private func setupButtons() {
        localizationButton.addTarget(self,
                                     action: #selector(localizationButtonTapped),
                                     for: .touchUpInside)
        
        sportTypeButton.addTarget(self,
                                  action: #selector(sportTypeButtonTapped),
                                  for: .touchUpInside)
    }
    
    @objc private func localizationButtonTapped() {
        router?.navigateToLocalizationSelect()
    }
    
    @objc private func sportTypeButtonTapped() {
        router?.navigateToSportTypeSelect(currentlySelected: searchSportTypes ?? SportType.allCases)
    }
}

extension MainEventsListViewController: MainEventsListViewControllerLogic {
    func presentEvents(events: [MainEventsListRow]) {
        dataSource.content = events
        tableView.reloadData()
    }
}

extension MainEventsListViewController: MenuItemDelegate {
    func didTapItem(_ itemType: MenuItemType) {
        if !(interactor?.isUserLoggedIn() ?? false) {
            router?.navigateToAuthentication()
        } else {
            switch itemType {
            case .profile:
                router?.navigateToUserProfile()
            case .add:
                router?.navigateToEventCreator()
            default:
                return
            }
        }
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
        let item = dataSource.content[index]
        
        switch  item {
        case let .event(presentable):
            router?.navigateToEventDetails(eventId: presentable.id)
        }
    }
}

extension MainEventsListViewController: MainEventsListSelectionDelegate {
    func didSelectSpotyTypes(_ sportTypes: [SportType]) {
        searchSportTypes = sportTypes
    }
    
    func didSelectLocalizationType(_ queryLocalizationType: QueryLocalizationType) {
        searchLocalizationType = queryLocalizationType
    }
}
