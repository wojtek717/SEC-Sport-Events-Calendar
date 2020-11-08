import UIKit

public struct LocalizationTableViewCellPresentable {
    let cityName: String
    let bottomText: String
}

class LocalizationTableViewCell: UITableViewCell {

    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var bottomLabel: UILabel!
    
    public func configure(with presentable: LocalizationTableViewCellPresentable) {
        self.cityLabel.text = presentable.cityName
        self.bottomLabel.text = presentable.bottomText
    }
}
