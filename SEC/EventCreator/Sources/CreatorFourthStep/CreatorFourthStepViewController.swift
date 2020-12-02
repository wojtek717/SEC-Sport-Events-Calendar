import UIKit
import Core
import CommonUI
import DesignSystem

protocol CreatorFourthStepViewControllerLogic: AnyObject {
    func presentLocalizationSearch(with presentables: [LocalizationTableViewCellPresentable])
}

final class CreatorFourthStepViewController: UIViewController {
    
    // MARK: - @IBOutlets

    @IBOutlet var searchTextField: SECTextFieldView!
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Public Properties

    var interactor: CreatorFourthStepInteractorLogic?
    var router: CreatorFourthStepRouterType?
    
    // MARK: - Private Properties
    
    private var dataSource = FourthStepDataSource()
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
        setupTableView()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Where?"
    }
    
    private func setupTextField() {
        searchTextField.setup(
            icon: CommonUI.R.image.search(),
            placeholder: Core.R.string.localizable.localizationSelect_textfield_placeholder(),
            target: interactor,
            action: #selector(interactor?.textFieldDidChange(_:)),
            delegate: self)
    }
    
    private func setupTableView() {
        tableView.register(CommonUI.R.nib.localizationTableViewCell)
        tableView.dataSource = dataSource
        tableView.delegate = self
        tableView.separatorStyle = .none
    }
}

extension CreatorFourthStepViewController: CreatorFourthStepViewControllerLogic {
    func presentLocalizationSearch(with presentables: [LocalizationTableViewCellPresentable]) {
        dataSource.content = presentables
        tableView.reloadData()
    }
}

extension CreatorFourthStepViewController: UITableViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension CreatorFourthStepViewController: UITextFieldDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //interactor?.localizationSelected(at: indexPath.row)
        interactor?.setLocalization(selected: indexPath.row)
        router?.navigateToFifthStep()
    }
}
