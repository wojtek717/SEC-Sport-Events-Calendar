import UIKit
import CommonUI

enum SportType {
    case running
    
    var image: UIImage? {
        switch self {
        default:
            return CommonUI.R.image.running()
        }
    }
}
