import UIKit
import Core
import CommonUI
import DesignSystem

protocol SmsConfirmationViewControllerLogic: AnyObject {
    func presentEventsList()
}

final class SmsConfirmationViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let botDistance: CGFloat = 15.0
        static let scaleAnimationTime: TimeInterval = 1.5
    }

    // MARK: - IBOutlets
    
    @IBOutlet private var bigImageView: UIImageView!
    @IBOutlet private var confirmButton: SecButton!
    @IBOutlet private var messageLabel: UILabel!
    @IBOutlet private var smsCodeTextField: UITextField!
    @IBOutlet private var confirmButtonBotConstraint: NSLayoutConstraint!
    
    // MARK: - Private Properties
    
    private let keyboardWorker = KeyboardWorker()
    
    // MARK: - Public Properties

    var interactor: SmsConfirmationInteractorLogic?
    var router: SmsConfirmationRouterType?
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
        self.bigImageView.transform = CGAffineTransform.identity
            .scaledBy(
                x: 1,
                y: 1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupTextField()
        setupButton()
        expandImage()
    }
    
    // MARK: - Private
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Confirm your number"
        
        let quitButton = UIBarButtonItem(
            image: CommonUI.R.image.close(),
            style: .plain,
            target: router,
            action: #selector(router?.dismiss))
        navigationItem.leftBarButtonItem = quitButton
        navigationItem.leftBarButtonItem?.tintColor = DesignSystem.R.color.secRed()
    }
    
    private func setup() {
        bigImageView.image = CommonUI.R.image.basketball()
        
        view.setupTapToDismiss()
        keyboardWorker.delegate = self
    }
    
    private func setupTextField() {
        smsCodeTextField.placeholder = "SMS Code"
        smsCodeTextField.keyboardType = .numberPad
        smsCodeTextField.delegate = self
        
        smsCodeTextField.addTarget(
            self,
            action: #selector(textFieldChanged),
            for: .editingChanged)
    }
    
    private func setupButton() {
        confirmButton.setTitle("Confirm", for: [])
        confirmButton.isEnabled = false
        confirmButton.addTarget(
            self,
            action: #selector(confirmButtonTapped),
            for: .touchUpInside)
    }
    
    private func expandImage() {
        UIView.animate(withDuration: Constants.scaleAnimationTime,
                                delay: 0,
                                options: []) {
            self.bigImageView.transform = CGAffineTransform.identity
                .scaledBy(
                    x: 4,
                    y: 4)
                .rotated(by: 3/4*CGFloat.pi)
        } completion: { _ in
            
        }
    }
}

extension SmsConfirmationViewController: SmsConfirmationViewControllerLogic {
    func presentEventsList() {
        router?.dismiss()
    }
}

extension SmsConfirmationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let maxLength = 6
        let currentString: NSString = NSString(string: textField.text ?? "")
        let newString = NSString(string: currentString.replacingCharacters(in: range, with: string))
        return newString.length <= maxLength
    }
}

extension SmsConfirmationViewController: KeyboardWorkerDelegate {
    func keyboardWillShow(with keyboardBounds: CGRect) {
        view.layoutIfNeeded()
        view.animateConstraint(confirmButtonBotConstraint, constant: keyboardBounds.height, view: view)
    }
    
    func keyboardWillHide(with keyboardBounds: CGRect) {
        view.layoutIfNeeded()
        view.animateConstraint(confirmButtonBotConstraint, constant: Constants.botDistance, view: view)
    }
}

@objc extension SmsConfirmationViewController {
    func textFieldChanged() {
        guard let codeLength = smsCodeTextField.text?.count else { return }
        
        confirmButton.isEnabled = codeLength == 6
    }
    
    func confirmButtonTapped() {
        guard let smsCode = smsCodeTextField.text else { return }
        interactor?.signIn(smsCode: smsCode)
    }
}

