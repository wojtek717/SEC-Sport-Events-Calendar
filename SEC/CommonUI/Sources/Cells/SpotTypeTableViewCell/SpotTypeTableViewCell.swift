import UIKit

public struct SportTypeTableViewCellPresentable {
    let image: UIImage?
    let title: String
    let isSelected: Bool
    
    public init(image: UIImage?,
                title: String,
                isSelected: Bool) {
        self.image = image
        self.title = title
        self.isSelected = isSelected
    }
}

public final class SportTypeTableViewCell: UITableViewCell {

    @IBOutlet private var sportImageView: UIImageView!
    @IBOutlet private var checkMarkImageView: UIImageView!
    @IBOutlet private var sportTitle: UILabel!
    
    public func configure(with presentable: SportTypeTableViewCellPresentable) {
        sportTitle.text = presentable.title
        sportImageView.image = presentable.image
        checkMarkImageView.isHidden = !presentable.isSelected
    }
    
}
