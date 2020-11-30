import UIKit

public final class CreatorSportTypeTableViewCell: UITableViewCell {
    
    @IBOutlet private var titleLabel: UILabel!
    
    public func configure(with title: String) {
        titleLabel.text = title
    }
    
}
