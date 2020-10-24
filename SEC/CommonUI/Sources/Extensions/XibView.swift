import UIKit

open class XibView: UIView {
    // MARK: - Public Properties
    open var xib: UIView? {
        assertionFailure("Xib property should be overriden")
        return nil
    }
    
    // MARK: - Initializers
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        loadXib()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        loadXib()
    }
    
    // MARK: - Private Properties
    
    private func loadXib() {
        guard let xib = xib else {
            assertionFailure("Xib not loaded.")
            return
        }
        
        xib.frame = bounds
        xib.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        xib.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(xib)
    }
}
