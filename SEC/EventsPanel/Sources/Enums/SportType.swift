import UIKit
import Core
import CommonUI

public enum SportType: Int, CaseIterable {
    case unknown = 0
    case running = 1
    
    public var image: UIImage? {
        switch self {
        default:
            return CommonUI.R.image.running()
        }
    }
    
    public var title: String {
        switch self {
        case .unknown:
            return "Unknown"
        case .running:
            return Core.R.string.localizable.sportType_running_title()
        }
    }
}
