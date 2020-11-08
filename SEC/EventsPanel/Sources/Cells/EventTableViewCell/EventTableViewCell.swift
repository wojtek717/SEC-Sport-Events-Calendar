import UIKit

public struct EventTableViewCellPresentable {
    let title: String
    let date: String
    let city: String
    let sport: SportType
}

class EventTableViewCell: UITableViewCell {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var sportTypeImageView: UIImageView!
    
    public func configure(with presentable: EventTableViewCellPresentable) {
        self.titleLabel.text = presentable.title
        self.dateLabel.text = presentable.date
        self.cityLabel.text = presentable.city
        self.sportTypeImageView.image = presentable.sport.image
    }
}
