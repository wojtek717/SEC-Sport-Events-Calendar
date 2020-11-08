import MapKit

public enum QueryLocalizationType {
    case everywhere
    case atUserLocalization(CLPlacemark?)
    case atSelectedLocalization(MKMapItem)
    
    var title: String {
        switch  self {
        case .everywhere:
            return "Wszedzie"
        case let .atUserLocalization(placemark):
            return placemark?.locality ?? "Moja okolica"
        case let .atSelectedLocalization(item):
            return item.name ?? ""
        }
    }
}
