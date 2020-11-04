import UIKit
import CommonUI
import DesignSystem

protocol LocalizationSelectViewControllerLogic: AnyObject {
    func presentUserPlace(with presentable: UserLocationViewPresentable)
    func presentLocalizationSearch(with presentables: [LocalizationTableViewCellPresentable])
}

final class LocalizationSelectViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var userLocationView: UserLocationView!
    @IBOutlet private var secTextField: SECTextFieldView!
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - Public Properties

    var interactor: LocalizationSelectInteractorLogic?
    var router: LocalizationSelectRouterType?
    
    // MARK: - Private Properties
    
    private var dataSource = LocalizationSelectDataSource()
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
        interactor?.getPlace()
    }
    
    override func viewDidLoad() {
        setup()
        interactor?.getPlace()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupTableView()
        
        secTextField.setup(icon: CommonUI.R.image.search(),
                           target: interactor,
                           action: #selector(interactor?.textFieldDidChange(_:)))
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(userLocalizationTapped))
        userLocationView.addGestureRecognizer(tap)
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Lokalizacja"
        
        let quitButton = UIBarButtonItem(
            image: CommonUI.R.image.close(),
            style: .plain,
            target: self,
            action: #selector(closeTapped))
        navigationItem.leftBarButtonItem = quitButton
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.R.color.secRed()
    }
    
    private func setupTableView() {
        tableView.register(R.nib.localizationTableViewCell)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.bouncesZoom = false
    }
    
    @objc private func closeTapped() {
        router?.dismiss()
    }
    
    @objc private func userLocalizationTapped() {
        router?.localizationTypeSelected(.atUserLocalization)
    }
}

extension LocalizationSelectViewController: LocalizationSelectViewControllerLogic {
    func presentLocalizationSearch(with presentables: [LocalizationTableViewCellPresentable]) {
        dataSource.content = presentables
        tableView.reloadData()
    }
    
    func presentUserPlace(with presentable: UserLocationViewPresentable) {
        userLocationView.setup(with: presentable)
    }
}

extension LocalizationSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
