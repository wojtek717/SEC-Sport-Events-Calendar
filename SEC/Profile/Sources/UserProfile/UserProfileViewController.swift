import Core
import DesignSystem
import CommonUI
import UIKit

protocol UserProfileViewControllerLogic: AnyObject {
    func presentUserData(name: String?, surname: String?)
}

final class UserProfileViewController: UIViewController {
    
    private enum ViewState {
        case editing
        case view
    }
    
    // MARK: - IBOutlets

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var nameTextField: SECTextFieldView!
    @IBOutlet private var surnameLabel: UILabel!
    @IBOutlet private var surnameTextField: SECTextFieldView!
    @IBOutlet private var editingButton: SecButton!
    
    // MARK: - Private Properties
    
    private var viewState: ViewState = .view
    
    // MARK: - Public Properties

    var interactor: UserProfileInteractorLogic?
    var router: UserProfileRouterType?
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextFields()
        setupButton()
        
        interactor?.fetchUserData()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Profile"
        
        let quitButton = UIBarButtonItem(
            image: CommonUI.R.image.close(),
            style: .plain,
            target: router,
            action: #selector(router?.dismiss))
        navigationItem.leftBarButtonItem = quitButton
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.R.color.secRed()
    }
    
    private func setupTextFields() {
        nameTextField.setup(
            icon: CommonUI.R.image.profile(),
            placeholder: "np. Wojciech")
        
        surnameTextField.setup(
            icon: CommonUI.R.image.profile(),
            placeholder: "np. Konury")
        
        nameTextField.isEnabled = false
        surnameTextField.isEnabled = false
    }
    
    private func setupButton() {
        editingButton.setTitle("Edytuj", for: [])
        editingButton.addTarget(
            self,
            action: #selector(editingButtonTapped),
            for: .touchUpInside)
    }
}

extension UserProfileViewController: UserProfileViewControllerLogic {
    func presentUserData(name: String?, surname: String?) {
        nameTextField.text = name
        surnameTextField.text = surname
    }
}

@objc private extension UserProfileViewController {
    func editingButtonTapped() {
        switch viewState {
        case .view:
            editingButton.setTitle("Zapisz", for: [])
            
            nameTextField.isEnabled = true
            surnameTextField.isEnabled = true
            
            viewState = .editing
        case .editing:
            if let name = nameTextField.text,
               let surname = surnameTextField.text {
                interactor?.updateUserData(name: name, surname: surname)
            }
            
            editingButton.setTitle("Edytuj", for: [])
            
            nameTextField.isEnabled = false
            surnameTextField.isEnabled = false
        }
    }
}
