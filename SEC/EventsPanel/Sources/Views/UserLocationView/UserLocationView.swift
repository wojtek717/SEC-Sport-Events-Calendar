import Core
import CommonUI
import UIKit

public struct UserLocationViewPresentable {
    let cityName: String
    let postCode: String
    let country: String
}

final class UserLocationView: XibView {
    // MARK: - IBOutlets
    
    @IBOutlet private var cityLabel: UILabel!
    @IBOutlet private var postCodeLabel: UILabel!
    @IBOutlet private var countryLabel: UILabel!
    @IBOutlet private var localizationImageView: UIImageView!
    
    // MARK: Public Properties
    
    override var xib: UIView? {
        R.nib.userLocationView(owner: self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        localizationImageView.image = CommonUI.R.image.locationPin()
    }
    
    // MARK: Public Methods

    public func setup(with presentable: UserLocationViewPresentable) {
        cityLabel.text = presentable.cityName
        postCodeLabel.text = presentable.postCode + ","
        countryLabel.text = presentable.country
    }
}
