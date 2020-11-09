import UIKit
import Core
import CommonUI

public enum SportType: Int, CaseIterable {
    case walking = 0
    case running = 1
    case swimming = 2
    case thriatlon = 3
    
    public var image: UIImage? {
        switch self {
        default:
            return CommonUI.R.image.running()
        }
    }
    
    public var title: String {
        switch self {
        case .walking:
            return Core.R.string.localizable.sportType_walking_title()
        case .running:
            return Core.R.string.localizable.sportType_running_title()
        case .swimming:
            return Core.R.string.localizable.sportType_Swimming_title()
        case .thriatlon:
            return Core.R.string.localizable.sportType_Thriatlon_title()
        }
    }
}
