import MapKit

public enum QueryLocalizationType {
    case everywhere
    case atUserLocalization
    case atSelectedLocalization(MKMapItem)
    
    var title: String {
        switch  self {
        case .everywhere:
            return "Wszedzie"
        case .atUserLocalization:
            return "Moja okolica"
        case let .atSelectedLocalization(item):
            return item.name ?? ""
        }
    }
}
