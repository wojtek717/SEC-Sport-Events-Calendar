import UIKit
import CommonUI

protocol CreatorSportTypeViewControllerLogic: AnyObject {}

final class CreatorSportTypeViewController: UIViewController {
    
    // MARK: - @IBOutlets
    
    @IBOutlet private var backgroundView: UIView!
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private var dataSource = CreatorSportTypeDataSource()
    
    // MARK: - Public Properties
    
    var interactor: CreatorSportTypeInteractorLogic?
    var router: CreatorSportTypeRouterType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTableView()
    }
    
    private func setup() {
        let tap = UITapGestureRecognizer(target: router, action: #selector(router?.dismiss))
        backgroundView.addGestureRecognizer(tap)
    }
    
    private func setupTableView() {
        tableView.register(CommonUI.R.nib.creatorSportTypeTableViewCell)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
}

extension CreatorSportTypeViewController: CreatorSportTypeViewControllerLogic {}

extension CreatorSportTypeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = SportType(rawValue: indexPath.row) else { return }
        
        router?.dismiss()
        interactor?.sportSelected(item)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
