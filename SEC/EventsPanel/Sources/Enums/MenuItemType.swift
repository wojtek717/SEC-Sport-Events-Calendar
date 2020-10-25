import UIKit
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
            return "Dodaj"
        case .profile:
            return "Profil"
        case .signedUp:
            return "Zapisane"
        default:
            return "Unknown"
        }
    }
}
