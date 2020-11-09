import UIKit
import Core
import CommonUI

public enum MenuItemType {
    case add
    case profile
    case signedUp
    case unknown
    
    public var icon: UIImage? {
        switch self {
        case .add:
            return CommonUI.R.image.addButton()
        case .profile:
            return CommonUI.R.image.profile()
        case .signedUp:
            return CommonUI.R.image.star()
        default:
            return nil
        }
    }
    
    // TODO: remove hardcoded strings
    public var title: String {
        switch self {
        case .add:
            return Core.R.string.localizable.bottom_menu_add_button(preferredLanguages: ["pl_PL"])
        case .profile:
            return Core.R.string.localizable.bottom_menu_profile_button()
        case .signedUp:
            return Core.R.string.localizable.bottom_menu_saved_button()
        default:
            return "Unknown"
        }
    }
}
