import MapKit

public enum QueryLocalizationType {
    case everywhere
    case atUserLocalization
    case atSelectedLocalization(MKMapItem)
}
