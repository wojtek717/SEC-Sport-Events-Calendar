import UIKit
import MapKit
import Core
import CommonUI

protocol CreatorFourthStepPresenterLogic {
    func presentSearchResponse(response: [MKMapItem])
}

final class CreatorFourthStepPresenter {

    // MARK: - Private Properties

    private weak var viewController: CreatorFourthStepViewControllerLogic?

    // MARK: - Initializers

    init(viewController: CreatorFourthStepViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension CreatorFourthStepPresenter: CreatorFourthStepPresenterLogic {
    func presentSearchResponse(response: [MKMapItem]) {
        let localizationPresentables = response.map {
            LocalizationTableViewCellPresentable(cityName: $0.placemark.locality ?? "", bottomText: $0.name ?? "")
        }
        
        viewController?.presentLocalizationSearch(with: localizationPresentables)
    }
}
