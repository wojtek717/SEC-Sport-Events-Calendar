import UIKit
import MapKit
import Core
import CommonUI
import DesignSystem

protocol LocalizationSelectViewControllerLogic: AnyObject {
    func presentUserPlace(with presentable: UserLocationViewPresentable)
    func presentLocalizationSearch(with presentables: [LocalizationTableViewCellPresentable])
    func localizationItemSelected(item: MKMapItem)
    func userlocalizationSelected(placemark: CLPlacemark?)
}

final class LocalizationSelectViewController: UIViewController {
    
    // MARK: - IBOutlets

    @IBOutlet private var userLocationView: UserLocationView!
    @IBOutlet private var secTextField: SECTextFieldView!
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var everywhereViewImageVIew: UIImageView!
    @IBOutlet private var everywhereView: UIView!
    @IBOutlet private var everywhereViewLabel: UILabel!
    
    // MARK: - Public Properties

    var interactor: LocalizationSelectInteractorLogic?
    var router: LocalizationSelectRouterType?
    
    // MARK: - Private Properties
    
    private var dataSource = LocalizationSelectDataSource()
    private let keyboardWorker = KeyboardWorker()
    private var isUserLocation: Bool = false
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        setup()
        interactor?.getPlace()
    }
    
    // MARK: - Private Methods
    
    private func setup() {
        setupTableView()
        
        secTextField.setup(icon: CommonUI.R.image.search(),
                           placeholder: Core.R.string.localizable.localizationSelect_textfield_placeholder(),
                           target: interactor,
                           action: #selector(interactor?.textFieldDidChange(_:)),
                           delegate: self)

        let tap1 = UITapGestureRecognizer(target: self, action: #selector(userLocalizationTapped))
        userLocationView.addGestureRecognizer(tap1)
        
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(everywhereTapped))
        everywhereView.addGestureRecognizer(tap2)
        everywhereViewImageVIew.image = CommonUI.R.image.world()
        everywhereViewLabel.text = Core.R.string.localizable.localizationSelect_search_everywhere_label()
        
        keyboardWorker.delegate = self
        userLocationView.isHidden = !isUserLocation
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Core.R.string.localizable.localizationSelect_title()
        
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
    }
    
    @objc private func closeTapped() {
        router?.dismiss()
    }
    
    @objc private func userLocalizationTapped() {
        interactor?.userLocalizationSelected()
    }
    
    @objc private func everywhereTapped() {
        router?.localizationTypeSelected(.everywhere)
    }
}

extension LocalizationSelectViewController: LocalizationSelectViewControllerLogic {
    func userlocalizationSelected(placemark: CLPlacemark?) {
        router?.localizationTypeSelected(.atUserLocalization(placemark))
    }
    
    func presentLocalizationSearch(with presentables: [LocalizationTableViewCellPresentable]) {
        dataSource.content = presentables
        tableView.reloadData()
    }
    
    func presentUserPlace(with presentable: UserLocationViewPresentable) {
        isUserLocation = true
        userLocationView.isHidden = !isUserLocation
        userLocationView.setup(with: presentable)
    }
    
    func localizationItemSelected(item: MKMapItem) {
        router?.localizationTypeSelected(.atSelectedLocalization(item))
    }
}

extension LocalizationSelectViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor?.localizationSelected(at: indexPath.row)
    }
}

extension LocalizationSelectViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

extension LocalizationSelectViewController: KeyboardWorkerDelegate {
    func keyboardWillShow(with keyboardBounds: CGRect) {
        userLocationView.isHidden = true
        view.layoutIfNeeded()
    }
    
    func keyboardWillHide(with keyboardBounds: CGRect) {
        if isUserLocation {
            userLocationView.isHidden = false
        }
        view.layoutIfNeeded()
    }
}
