import UIKit
import CommonUI

protocol SportTypeSelectPresenterLogic {
    func presentSports(selectedSports: [SportType])
}

final class SportTypeSelectPresenter {

    // MARK: - Private Properties

    private weak var viewController: SportTypeSelectViewControllerLogic?

    // MARK: - Initializers

    init(viewController: SportTypeSelectViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension SportTypeSelectPresenter: SportTypeSelectPresenterLogic {
    func presentSports(selectedSports: [SportType]) {
        var isAnySelected = false
        
        let presentables: [SportTypeTableViewCellPresentable] = SportType.allCases.compactMap {
            let isSelected = selectedSports.contains($0)
            if isSelected { isAnySelected = true }
            return SportTypeTableViewCellPresentable(image: $0.image,
                                              title: $0.title,
                                              isSelected: isSelected)
        }
        viewController?.presentSports(with: presentables, isAnySelected: isAnySelected)
    }
}
