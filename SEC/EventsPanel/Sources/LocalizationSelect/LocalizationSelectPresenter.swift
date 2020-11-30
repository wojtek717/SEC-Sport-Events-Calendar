import UIKit
import CoreLocation
import MapKit
import CommonUI

protocol LocalizationSelectPresenterLogic {
    func presentUserPlace(placeMark: CLPlacemark)
    func presentSearchResponse(response: [MKMapItem])
    func presentLocalizationEvents(item: MKMapItem)
    func presentLocalizationEvents(placemark: CLPlacemark?)
}

final class LocalizationSelectPresenter {
    
    // MARK: - Private Properties
    
    private weak var viewController: LocalizationSelectViewControllerLogic?
    
    // MARK: - Initializers
    
    init(viewController: LocalizationSelectViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension LocalizationSelectPresenter: LocalizationSelectPresenterLogic {
    func presentSearchResponse(response: [MKMapItem]) {
        let localizationPresentables = response.map {
            LocalizationTableViewCellPresentable(cityName: $0.placemark.locality ?? "", bottomText: $0.name ?? "")
        }
        
        viewController?.presentLocalizationSearch(with: localizationPresentables)
    }
    
    func presentUserPlace(placeMark: CLPlacemark) {
        let presentable = UserLocationViewPresentable(cityName: placeMark.locality ?? "",
                                                      postCode: placeMark.postalCode ?? "",
                                                      country: placeMark.country ?? "")
        
        viewController?.presentUserPlace(with: presentable)
    }
    
    func presentLocalizationEvents(item: MKMapItem) {
        viewController?.localizationItemSelected(item: item)
    }
    
    func presentLocalizationEvents(placemark: CLPlacemark?) {
        viewController?.userlocalizationSelected(placemark: placemark)
    }
}
