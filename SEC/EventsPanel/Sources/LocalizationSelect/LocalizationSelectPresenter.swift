import UIKit
import CoreLocation

protocol LocalizationSelectPresenterLogic {
    func presentUserPlace(placeMark: CLPlacemark)
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
    func presentUserPlace(placeMark: CLPlacemark) {
        let presentable = UserLocationViewPresentable(cityName: placeMark.locality ?? "",
                                                      postCode: placeMark.postalCode ?? "",
                                                      country: placeMark.country ?? "")
        
        viewController?.presentUserPlace(with: presentable)
    }
}
