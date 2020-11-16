import Core
import UIKit

public final class SECTextFieldView: XibView {
    // MARK: - IBOutlets
    
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var textField: UITextField!
    
    // MARK: Public Properties
    
    public override var xib: UIView? {
        R.nib.secTextFieldView(owner: self)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        containerView.addGestureRecognizer(tap)
    }
    
    public var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    public var isEnabled: Bool = true {
        didSet {
            textField.isEnabled = isEnabled
        }
    }
    
    public var text: String? {
        get {
            textField.text
        }
        set(text) {
            textField.text = text
        }
    }
    
    // MARK: Private Methods
    
    @objc func handleTap() {
        textField.becomeFirstResponder()
    }
    
    // MARK: Public Methods
    
    public func setup(icon: UIImage?,
                      placeholder: String,
                      target: Any? = nil,
                      action: Selector? = nil,
                      delegate: UITextFieldDelegate? = nil) {
        iconImageView.image = icon
        textField.placeholder = placeholder
        
        if let action = action {
            textField.addTarget(target, action: action, for: .editingChanged)
        }
        textField.delegate = delegate
    }
}
