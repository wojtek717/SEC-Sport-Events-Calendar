import UIKit

public protocol MenuItemDelegate: AnyObject {    
    func didTapItem(_ itemType: MenuItemType)
}
