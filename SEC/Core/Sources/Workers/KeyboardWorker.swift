import UIKit

@objc public protocol KeyboardWorkerDelegate: AnyObject {
    @objc optional func keyboardWillShow(with keyboardBounds: CGRect)
    @objc optional func keyboardWillHide(with keyboardBounds: CGRect)
    @objc optional func keyboardDidChange(with keyboardBounds: CGRect)
}

public final class KeyboardWorker {
    private enum Constants {
        enum Keys {
            static let keyboardBoundsKey = "UIKeyboardBoundsUserInfoKey"
        }
    }

    public weak var delegate: KeyboardWorkerDelegate?

    public var isKeyboardVisible = false

    public init() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillShow(notification:)),
                name: UIResponder.keyboardWillShowNotification,
                object: nil)

        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardWillHide(notification:)),
                name: UIResponder.keyboardWillHideNotification,
                object: nil)

        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(keyboardDidChangeFrameNotification(notification:)),
                name: UIResponder.keyboardDidChangeFrameNotification,
                object: nil)
    }

    @objc private func keyboardWillShow(notification: Notification) {
        isKeyboardVisible = true

        guard let bounds = notification.userInfo?[Constants.Keys.keyboardBoundsKey] as? CGRect else {
            return assertionFailure("Couldn't get the bounds of the keyboard")
        }

        delegate?.keyboardWillShow?(with: bounds)
    }

    @objc private func keyboardWillHide(notification: Notification) {
        isKeyboardVisible = false

        guard let bounds = notification.userInfo?[Constants.Keys.keyboardBoundsKey] as? CGRect else {
            return assertionFailure("Couldn't get the bounds of the keyboard")
        }

        delegate?.keyboardWillHide?(with: bounds)
    }

    @objc private func keyboardDidChangeFrameNotification(notification: Notification) {
        guard let bounds = notification.userInfo?[Constants.Keys.keyboardBoundsKey] as? CGRect else {
            return assertionFailure("Couldn't get the bounds of the keyboard")
        }

        guard isKeyboardVisible else {
            return
        }

        delegate?.keyboardDidChange?(with: bounds)
    }
}
