import UIKit

protocol OnboardingLocationInteractorLogic {}
protocol OnboardingLocationDataStore {}

final class OnboardingLocationInteractor: OnboardingLocationDataStore {

    // MARK: - Private Properties

    private let presenter: OnboardingLocationPresenterLogic

    // MARK: - Initializers

    init(presenter: OnboardingLocationPresenterLogic) {
        self.presenter = presenter
    }
}

extension OnboardingLocationInteractor: OnboardingLocationInteractorLogic {}
