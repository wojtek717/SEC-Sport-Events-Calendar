import Core
import MapKit

public enum QueryLocalizationType {
    case everywhere
    case atUserLocalization(CLPlacemark?)
    case atSelectedLocalization(MKMapItem)
    
    var title: String {
        switch  self {
        case .everywhere:
            return Core.R.string.localizable.localizationType_everywhere_title()
        case let .atUserLocalization(placemark):
            return placemark?.locality ?? Core.R.string.localizable.localizationType_atUserLocation_title()
        case let .atSelectedLocalization(item):
            return item.name ?? ""
        }
    }
}
