import UIKit
import Core
import CommonUI
import DesignSystem

protocol CreatorFifthStepViewControllerLogic: AnyObject {
    func presentParticipantsValue(_ value: String)
    func shouldPresentErrorLabel(_ enabled: Bool)
    func presentMainEventsList()
}

final class CreatorFifthStepViewController: UIViewController {
    
    @IBOutlet private var minusButton: UIButton!
    @IBOutlet private var plusButton: UIButton!
    @IBOutlet private var countTextField: UITextField!
    @IBOutlet private var errorLabel: UILabel!
    @IBOutlet private var addButton: SecButton!
    @IBOutlet private var infoLabel: UILabel!
    
    // MARK: - Public Properties
    
    var interactor: CreatorFifthStepInteractorLogic?
    var router: CreatorFifthStepRouterType?
    
    // MARK: - View Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationBar()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        setupButtons()
    }
    
    // MARK: - Private Methods
    
    private func setupNavigationBar() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Core.R.string.localizable.creator_howMany_title()
    }
    
    private func setup() {
        countTextField.keyboardType = .numberPad
        countTextField.delegate = self
        
        infoLabel.text = Core.R.string.localizable.creator_howMany_info_label()
        errorLabel.text = Core.R.string.localizable.creator_howMany_error_label()
        
        errorLabel.isHidden = true
        
        countTextField.addTarget(
            self,
            action: #selector(textfieldChanged),
            for: .editingChanged)
        
        view.setupTapToDismiss()
        
        interactor?.setParticipantsValue(50)
    }
    
    private func setupButtons() {
        addButton.setTitle(Core.R.string.localizable.creator_howMany_add_button(), for: [])
        
        addButton.addTarget(
            self,
            action: #selector(addButtonTapped),
            for: .touchUpInside)
        
        plusButton.addTarget(
            self,
            action: #selector(plusButtonTapped),
            for: .touchUpInside)
        
        minusButton.addTarget(
            self,
            action: #selector(minusButtonTapped),
            for: .touchUpInside)
    }
}

extension CreatorFifthStepViewController: CreatorFifthStepViewControllerLogic {
    func presentMainEventsList() {
        router?.dismiss()
    }
    
    func shouldPresentErrorLabel(_ enabled: Bool) {
        errorLabel.isHidden = !enabled
    }
    
    func presentParticipantsValue(_ value: String) {
        countTextField.text = value
    }
}

@objc private extension CreatorFifthStepViewController {
    func plusButtonTapped() {
        interactor?.changeParticipantsValue(by: 1)
    }
    
    func minusButtonTapped() {
        interactor?.changeParticipantsValue(by: -1)
    }
    
    func addButtonTapped() {
        interactor?.addEvent()
    }
    
    func textfieldChanged() {
        guard let value = countTextField.text,
              let numericValue = Int(value)
        else { return }
        
        interactor?.setParticipantsValue(numericValue)
    }
}

extension CreatorFifthStepViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            
            if updatedText == "" {
                interactor?.setParticipantsValue(0)
                return false
            }
            
            guard let numericValue = Int(updatedText) else { return false }
            
            if numericValue >= 500 {
                errorLabel.isHidden = false
            }
            
            return numericValue <= 500
            
        } else {
            return false
        }
    }
}
