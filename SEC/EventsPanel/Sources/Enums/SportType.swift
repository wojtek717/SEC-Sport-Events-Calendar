import UIKit
import Core
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
    
    var title: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .running:
            return Core.R.string.localizable.sportType_running_title()
        }
    }
}
