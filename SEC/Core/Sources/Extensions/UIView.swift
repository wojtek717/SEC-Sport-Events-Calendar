import UIKit

public extension UIView {    
    func setupTapToDismiss(cancelsTouchesInView: Bool = true) {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = cancelsTouchesInView
        addGestureRecognizer(tap)
    }

    @objc
    func dismissKeyboard() {
        endEditing(true)
    }
    
    func animateConstraint(_ constraint: NSLayoutConstraint,
                           constant: CGFloat,
                           view: UIView) {
        constraint.constant = constant
        UIView.animate(withDuration: 0.2) { [weak view] in
            view?.layoutIfNeeded()
        }
    }
}
