import UIKit
import Core
import CommonUI

final class BotMenuItemView: XibView {
    // MARK: - IBOutlets

    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    
    // MARK: Private Properties
    var itemType: MenuItemType = .unknown 
    
    // MARK: Public Properties
    
    public weak var delegate: MenuItemDelegate?
    
    override var xib: UIView? {
        R.nib.botMenuItemView(owner: self)
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: Public Methods

    public func setup(itemType: MenuItemType, delegate: MenuItemDelegate? = nil) {
        self.itemType = itemType
        iconImageView.image = itemType.icon
        titleLabel.text = itemType.title
        
        self.delegate = delegate
    }
    
    // MARK: Button Action
    
    @IBAction func itemTapped(_ sender: Any) {
        delegate?.didTapItem(itemType)
    }
}
