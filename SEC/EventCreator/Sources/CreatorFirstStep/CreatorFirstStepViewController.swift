import UIKit
import Core
import CommonUI
import DesignSystem

protocol CreatorFirstStepViewControllerLogic: AnyObject {}

final class CreatorFirstStepViewController: UIViewController {
    
    // MARK: - @IBOutlets

    @IBOutlet private var cornerImageView: UIImageView!
    @IBOutlet private var nextButton: SecButton!
    @IBOutlet private var nextButtonBotConstraint: NSLayoutConstraint!
    @IBOutlet private var titleTextField: UITextField!
    @IBOutlet private var descriptionLabel: UILabel!
    
    // MARK: - Private Properties
    
    private let keyboardWorker = KeyboardWorker()
    
    // MARK: - Public Properties

    var interactor: CreatorFirstStepInteractorLogic?
    var router: CreatorFirstStepRouterType?
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Core.R.string.localizable.creator_firstStep_title()
        
        let quitButton = UIBarButtonItem(
            image: CommonUI.R.image.close(),
            style: .plain,
            target: router,
            action: #selector(router?.dismiss))
        navigationItem.leftBarButtonItem = quitButton
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.R.color.secRed()
    }
    
    private func setup() {
        view.setupTapToDismiss()
        keyboardWorker.delegate = self
        
        descriptionLabel.text = Core.R.string.localizable.creator_firstStep_desciption_label()
        
        cornerImageView.image = CommonUI.R.image.basketball()
        
        nextButton.setTitle(
            Core.R.string.localizable.creator_next_button(),
            for: [])
        nextButton.addTarget(
            self,
            action: #selector(nextButtonTapped),
            for: .touchUpInside)
        
        titleTextField.placeholder = Core.R.string.localizable.creator_firstStep_title_textfield_placeholder()
        titleTextField.addTarget(
            self,
            action: #selector(textFieldChanged),
            for: .editingChanged)
    }
    
    @objc private func nextButtonTapped() {
        
    }
    
    @objc private func textFieldChanged() {
        nextButton.isEnabled = titleTextField.text?.count ?? 0 >= 6
    }
}

extension CreatorFirstStepViewController: CreatorFirstStepViewControllerLogic {}

extension CreatorFirstStepViewController: KeyboardWorkerDelegate {
    func keyboardWillShow(with keyboardBounds: CGRect) {
        view.layoutIfNeeded()
        view.animateConstraint(nextButtonBotConstraint, constant: keyboardBounds.height, view: view)
    }
    
    func keyboardWillHide(with keyboardBounds: CGRect) {
        view.layoutIfNeeded()
        view.animateConstraint(nextButtonBotConstraint, constant: .zero, view: view)
    }
}
