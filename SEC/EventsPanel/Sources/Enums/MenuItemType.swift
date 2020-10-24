import UIKit
import CommonUI

public enum MenuItemType {
    case add
    case profile
    case signedUp
    case unknown
    
    public var icon: UIImage? {
        switch self {
        default:
            return CommonUI.R.image.calendar()
        }
    }
    
    // TODO: remove hardcoded strings
    public var title: String {
        switch self {
        case .add:
            return "Add"
        case .profile:
            return "Profile"
        case .signedUp:
            return "Signed up"
        default:
            return "Unknown"
        }
    }
}
