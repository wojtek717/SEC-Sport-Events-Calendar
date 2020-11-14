import UIKit
import DesignSystem

@IBDesignable
public class SecButton: UIButton {
    public override var isEnabled: Bool {
        didSet {
            if isEnabled {
                backgroundColor = defaultBackgroundColor
            } else {
                backgroundColor = defaultBackgroundColor?.withAlphaComponent(0.5)
            }
        }
    }
    
    fileprivate var defaultBackgroundColor: UIColor?

    public override func awakeFromNib() {
        super.awakeFromNib()
        
        defaultBackgroundColor = backgroundColor
        
        titleLabel?.font = UIFont(resource: DesignSystem.R.font.cairoBold, size: 18.0)
        
        self.addTarget(self, action: #selector(buttonTouchDown), for: .touchDown)
        self.addTarget(self, action: #selector(buttonTouchUpInside), for: .touchUpInside)
    }
    
    @objc private func buttonTouchDown() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    @objc private func buttonTouchUpInside() {
        UIView.animate(withDuration: 0.2, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
