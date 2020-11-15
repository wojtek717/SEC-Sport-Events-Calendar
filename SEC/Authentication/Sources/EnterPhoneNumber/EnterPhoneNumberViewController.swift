import UIKit
import DesignSystem
import Core
import CommonUI
import Firebase
import PhoneNumberKit

protocol EnterPhoneNumberViewControllerLogic: AnyObject {
    func navigateToSmsConfirmation()
}

final class EnterPhoneNumberViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let scaleFactor: CGFloat = 30
        static let scaleAnimationTime: TimeInterval = 1.5
        static let botDistance: CGFloat = 15.0
    }

    // MARK: - IBOutlets
    
    @IBOutlet private var phoneNumberTextField: PhoneNumberTextField!
    @IBOutlet private var sendButton: SecButton!
    @IBOutlet private var bigImageView: UIImageView!
    @IBOutlet private var sendButtonBotConstraint: NSLayoutConstraint!
    
    // MARK: - Private Properties
    
    private let keyboardWorker = KeyboardWorker()
    
    // MARK: - Public Properties

    var interactor: EnterPhoneNumberInteractorLogic?
    var router: EnterPhoneNumberRouterType?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTextField()
    }
    
    private func setup() {
        sendButton.isEnabled = phoneNumberTextField.isValidNumber
        sendButton.addTarget(
            self,
            action: #selector(sendButtonTapped),
            for: .touchUpInside)
        
        bigImageView.image = CommonUI.R.image.tenisBall()
        
        view.setupTapToDismiss()
        keyboardWorker.delegate = self
    }
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Hello"
        
        let quitButton = UIBarButtonItem(
            image: CommonUI.R.image.close(),
            style: .plain,
            target: self,
            action: #selector(closeTapped))
        navigationItem.leftBarButtonItem = quitButton
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.R.color.secRed()
    }
    
    private func setupTextField() {
        phoneNumberTextField.withFlag = true
        phoneNumberTextField.withPrefix = true
        phoneNumberTextField.withExamplePlaceholder = true
        phoneNumberTextField.addTarget(
            self,
            action: #selector(textFieldChanged),
            for: .editingChanged)
    }
}

extension EnterPhoneNumberViewController: EnterPhoneNumberViewControllerLogic {
    func navigateToSmsConfirmation() {
        UIView.animate(withDuration: Constants.scaleAnimationTime,
                                delay: 0,
                                options: []) {
            self.bigImageView.transform = CGAffineTransform.identity
                .scaledBy(
                    x: Constants.scaleFactor,
                    y: Constants.scaleFactor)
                .rotated(by: 3/4*CGFloat.pi)
        } completion: { _ in
            self.router?.navigateToSmsConfirmation()
        }
    }
}

@objc private extension EnterPhoneNumberViewController {
    func closeTapped() {
        router?.dismiss()
    }
    
    func textFieldChanged() {
        sendButton.isEnabled = phoneNumberTextField.isValidNumber
    }
    
    func sendButtonTapped() {
        guard let phoneNumber = phoneNumberTextField.text else { return }
        
        interactor?.verifyPhoneNumber(phoneNumber: phoneNumber)
    }
}

extension EnterPhoneNumberViewController: KeyboardWorkerDelegate {
    func keyboardWillShow(with keyboardBounds: CGRect) {
        view.layoutIfNeeded()
        view.animateConstraint(sendButtonBotConstraint, constant: keyboardBounds.height, view: view)
    }
    
    func keyboardWillHide(with keyboardBounds: CGRect) {
        view.layoutIfNeeded()
        view.animateConstraint(sendButtonBotConstraint, constant: Constants.botDistance, view: view)
    }
}
