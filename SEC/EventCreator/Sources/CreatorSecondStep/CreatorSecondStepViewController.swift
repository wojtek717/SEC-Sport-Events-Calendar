import UIKit
import Core
import CommonUI
import DesignSystem

protocol CreatorSecondStepViewControllerLogic: AnyObject {}

final class CreatorSecondStepViewController: UIViewController {
    
    private enum Constants {
        static let minChars = 6
    }
    
    // MARK: - IBOutlets

    @IBOutlet private var textFieldContainer: UIView!
    @IBOutlet private var dexscriptionTextView: UITextView!
    @IBOutlet private var nextButton: SecButton!
    @IBOutlet private var nextButtonBotConstraint: NSLayoutConstraint!
    @IBOutlet private var countLabel: UILabel!
    
    // MARK: - Private Properties
    
    let keyboardWorker = KeyboardWorker()
    
    // MARK: - Public Properties

    var interactor: CreatorSecondStepInteractorLogic?
    var router: CreatorSecondStepRouterType?
    
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
        title = "Event's description"
    }
    
    private func setup() {
        view.setupTapToDismiss()
        keyboardWorker.delegate = self
        
        nextButton.setTitle(
            Core.R.string.localizable.creator_next_button(),
            for: [])
        nextButton.addTarget(
            self,
            action: #selector(nextButtonTapped),
            for: .touchUpInside)
        
        validateDescription(text: dexscriptionTextView.text)
        
        dexscriptionTextView.delegate = self
        dexscriptionTextView.text = ""
    }
    
    @objc private func nextButtonTapped() {
        view.dismissKeyboard()
        
        router?.navigateToThirdStep()
    }
    
    private func validateDescription(text: String) {
        nextButton.isEnabled = text.count >= Constants.minChars
        countLabel.text = String(text.count) + "/" + String(Constants.minChars)
    }
}

extension CreatorSecondStepViewController: CreatorSecondStepViewControllerLogic {}

extension CreatorSecondStepViewController: KeyboardWorkerDelegate {
    func keyboardWillShow(with keyboardBounds: CGRect) {
        view.layoutIfNeeded()
        view.animateConstraint(nextButtonBotConstraint, constant: keyboardBounds.height, view: view)
    }
    
    func keyboardWillHide(with keyboardBounds: CGRect) {
        view.layoutIfNeeded()
        view.animateConstraint(nextButtonBotConstraint, constant: .zero, view: view)
    }
}

extension CreatorSecondStepViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        interactor?.setDescription(textView.text)
        validateDescription(text: textView.text)
    }
}
