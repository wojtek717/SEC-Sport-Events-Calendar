import Core
import CommonUI
import DesignSystem
import UIKit

protocol SportTypeSelectViewControllerLogic: AnyObject {
    func presentSports(with presentables: [SportTypeTableViewCellPresentable], isAnySelected: Bool)
}

final class SportTypeSelectViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var selectButton: SecButton!
    
    // MARK: - Public Properties
    
    var interactor: SportTypeSelectInteractorLogic?
    var router: SportTypeSelectRouterType?
    
    // MARK: - Private Properties
    
    private var dataSource = SportTypeSelectDataSource()
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        setup()
        
        interactor?.prepareSports()
        
        super.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupTableView()
        setupButton()
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Core.R.string.localizable.sportType_title()
        navigationController?.navigationBar.sizeToFit()
        navigationController?.navigationBar.barTintColor = .white
        
        let quitButton = UIBarButtonItem(
            image: CommonUI.R.image.close(),
            style: .plain,
            target: self,
            action: #selector(closeTapped))
        navigationItem.leftBarButtonItem = quitButton
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.R.color.secRed()
    }
    
    private func setupTableView() {
        tableView.register(CommonUI.R.nib.spotTypeTableViewCell)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupButton() {
        selectButton.setTitle(Core.R.string.localizable.sportType_select_button(), for: [])
        selectButton.addTarget(self,
                               action: #selector(selectButtonTapped),
                               for: .touchUpInside)
    }
}

extension SportTypeSelectViewController: SportTypeSelectViewControllerLogic {
    func presentSports(with presentables: [SportTypeTableViewCellPresentable], isAnySelected: Bool) {
        dataSource.content = presentables
        tableView.reloadData()
        
        selectButton.isEnabled = isAnySelected
    }
}

extension SportTypeSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let sport = SportType(rawValue: indexPath.row) else { return }
        interactor?.sportSelected(sport)
    }
}

@objc private extension SportTypeSelectViewController {
    func closeTapped() {
        router?.dismiss()
    }
    
    func selectButtonTapped() {
        guard let sports = interactor?.currentlySelected else {
            return
        }
        router?.sportTypesSelected(sports)
    }
}
