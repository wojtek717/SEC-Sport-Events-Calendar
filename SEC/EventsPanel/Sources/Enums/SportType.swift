import UIKit
import CommonUI

enum SportType: Int, CaseIterable {
    case unknown = 0
    case running = 1
    
    var image: UIImage? {
        switch self {
        default:
            return CommonUI.R.image.running()
        }
    }
}
