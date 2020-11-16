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
        
        var title: String {
            switch self {
            case .editing:
                return Core.R.string.localizable.enterPhoneNumber_send_button()
            case .view:
                return Core.R.string.localizable.profile_edit_button()
            }
        }
    }
    
    // MARK: - IBOutlets

    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var nameTextField: SECTextFieldView!
    @IBOutlet private var surnameLabel: UILabel!
    @IBOutlet private var surnameTextField: SECTextFieldView!
    @IBOutlet private var editingButton: SecButton!
    @IBOutlet private var editingButtonBotConstraint: NSLayoutConstraint!
    
    // MARK: - Private Properties
    
    private var viewState: ViewState = .view
    private let keyboardWorker = KeyboardWorker()
    
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
        title = Core.R.string.localizable.profile_title()
        
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
            placeholder: Core.R.string.localizable.profile_name_placeholder())
        
        surnameTextField.setup(
            icon: CommonUI.R.image.profile(),
            placeholder: Core.R.string.localizable.profile_surname_placeholder())
        
        nameTextField.isEnabled = false
        surnameTextField.isEnabled = false
    }
    
    private func setupButton() {
        editingButton.setTitle(viewState.title, for: [])
        editingButton.addTarget(
            self,
            action: #selector(editingButtonTapped),
            for: .touchUpInside)
    }
    
    private func setup() {
        nameLabel.text = Core.R.string.localizable.profile_name()
        surnameLabel.text = Core.R.string.localizable.profile_surname()
        
        keyboardWorker.delegate = self
        view.setupTapToDismiss()
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
            editingButton.setTitle(viewState.title, for: [])
            
            nameTextField.isEnabled = true
            surnameTextField.isEnabled = true
            
            viewState = .editing
        case .editing:
            if let name = nameTextField.text,
               let surname = surnameTextField.text {
                interactor?.updateUserData(name: name, surname: surname)
            }
            
            editingButton.setTitle(viewState.title, for: [])
            
            nameTextField.isEnabled = false
            surnameTextField.isEnabled = false
            
            viewState = .view
        }
    }
}


extension UserProfileViewController: KeyboardWorkerDelegate {
    func keyboardWillShow(with keyboardBounds: CGRect) {
        view.layoutIfNeeded()
        view.animateConstraint(editingButtonBotConstraint, constant: keyboardBounds.height, view: view)
    }
    
    func keyboardWillHide(with keyboardBounds: CGRect) {
        view.layoutIfNeeded()
        view.animateConstraint(editingButtonBotConstraint, constant: 15.0, view: view)
    }
}
