import UIKit

protocol CreatorFifthStepPresenterLogic {
    func preapareParticipantValue(_ value: Int)
    func errorLabelIsEnabled(_ enabled: Bool)
    func presentMainEventList()
}

final class CreatorFifthStepPresenter {

    // MARK: - Private Properties

    private weak var viewController: CreatorFifthStepViewControllerLogic?

    // MARK: - Initializers

    init(viewController: CreatorFifthStepViewControllerLogic?) {
        self.viewController = viewController
    }
}

extension CreatorFifthStepPresenter: CreatorFifthStepPresenterLogic {
    func presentMainEventList() {
        viewController?.presentMainEventsList()
    }
    
    func errorLabelIsEnabled(_ enabled: Bool) {
        viewController?.shouldPresentErrorLabel(enabled)
    }
    
    func preapareParticipantValue(_ value: Int) {
        viewController?.presentParticipantsValue(String(value))
    }
}
